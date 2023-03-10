import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:project_x/src/constants/constants.dart';
import 'package:project_x/src/features/screens/Map%20Screen/mapScreen2.dart';

import '../../../size_config/size_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchFieldController = TextEditingController();

  static DetailsResult? destination;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? debounce;

  @override
  void initState() {
    super.initState();

    googlePlace = GooglePlace(googleApiKey);
  }

  void autoCompleteSearch(String value) async {
    if (value.contains(RegExp(r'[^\w\s]'))) {
      setState(() {
        predictions = [
          AutocompletePrediction(
            description: 'no suggestion',
            placeId: '',
            types: [],
            matchedSubstrings: [],
            structuredFormatting:
                StructuredFormatting(mainText: '', secondaryText: ''),
          )
        ];
      });
      return;
    }
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: getScreenHeight(230),
            width: getScreenWidth(375),
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 211, 210, 210)),
            child: MapScreen(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: getScreenWidth(16),
              right: getScreenWidth(16),
              bottom: getScreenHeight(10)),
          child: Column(
            children: [
              TextField(
                controller: searchFieldController,
                onChanged: (value) {
                  if (debounce?.isActive ?? false) debounce!.cancel();
                  debounce = Timer(Duration(milliseconds: 50), () {
                    if (value.isNotEmpty) {
                      autoCompleteSearch(value);
                    } else {
                      setState(() {
                        predictions = [];
                        destination = null;
                      });
                    }
                  });
                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: "Search your destination location",
                  hintStyle: TextStyle(
                    fontSize: getScreenWidth(15),
                  ),
                  suffixIcon: searchFieldController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            size: getScreenWidth(19),
                          ),
                          onPressed: () {
                            setState(() {
                              searchFieldController.clear();
                              predictions = [];
                            });
                          },
                        )
                      : null,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: predictions.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading: Icon(Icons.location_pin),
                    title: Text(
                      predictions[index].description.toString(),
                    ),
                    onTap: () async {
                      final placeId = predictions[index].placeId;
                      final details = await googlePlace.details.get(placeId!);
                      if (details != null &&
                          details.result != null &&
                          mounted) {
                        setState(() {
                          destination = details.result;
                          searchFieldController.text =
                              details.result!.name!.toString();
                          predictions = [];
                        });
                      }
                    },
                  );
                }),
              ),
              const Divider(
                height: 5,
                thickness: 2,
                color: Color.fromARGB(160, 228, 226, 226),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getScreenHeight(5),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      commonLocations("KFA"),
                      commonLocations("Rafiki"),
                      commonLocations("Kabu Main Gate"),
                      commonLocations("Kiamunyi"),
                      commonLocations("Kampi Ya Moto"),
                      commonLocations("Mercy Njeri"),
                      commonLocations("Barkesen"),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 4,
                thickness: 2,
                color: Color.fromARGB(160, 228, 226, 226),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container commonLocations(text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getScreenWidth(4)),
      child: ElevatedButton(
        onPressed: () {
          // placesAutocomplete("Dubai");
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: getScreenWidth(10)),
          backgroundColor: Color.fromARGB(160, 228, 226, 226),
          foregroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : appPrimaryColor,
          elevation: 0,
          fixedSize: Size(double.infinity, getScreenWidth(40)),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Text(text,
            style: TextStyle(
                fontSize: getScreenWidth(12), fontWeight: FontWeight.w600)),
      ),
    );
  }
}
