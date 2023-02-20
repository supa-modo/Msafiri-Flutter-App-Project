import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common_widgets/defaultButton.dart';
import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';
import 'location_list.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key, this.pressed}) : super(key: key);
  final VoidCallback? pressed;

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  bool mPesa = true;
  bool cash = false;
  late String _mpesaNumber;

  // void placesAutocomplete(String query) async {
  //   Uri uri = Uri.https(
  //       "maps.googleapis.com",
  //       'maps/api/place/autocomplete/json',
  //       {"input": query, "key": googleApiKey});

  //   String? response = await NetworkUtils.fetchUrl(uri);

  //   if (response != null) {
  //     print(response);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          fontSize: getScreenWidth(22),
          fontWeight: FontWeight.bold,
          color: appPrimaryColor,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 95, 94, 94)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text(
          "New Trip",
          style: TextStyle(color: Color.fromARGB(255, 95, 94, 94)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "Set Your Desination",
              style: TextStyle(
                color: appPrimaryColor,
                fontSize: getScreenWidth(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: getScreenHeight(220),
                width: getScreenWidth(375),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 211, 210, 210)),
                // child: const MapScreen3(),
              ),
            ),
            Form(
              child: Padding(
                padding: EdgeInsets.only(
                    left: getScreenWidth(16),
                    right: getScreenWidth(16),
                    bottom: getScreenHeight(10)),
                child: TextFormField(
                  onChanged: (value) {
                    // placesAutocomplete(value);
                  },
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: "Search your destination location",
                    hintStyle: TextStyle(fontSize: getScreenWidth(15)),
                    // prefixIcon: Padding(
                    //   padding:
                    //       EdgeInsets.symmetric(vertical: getScreenHeight(12)),
                    //   child: SvgPicture.asset(
                    //     "assets/icons/location.svg",
                    //     height: getScreenHeight(10),
                    //     width: getScreenWidth(10),
                    //     color: const Color.fromARGB(255, 143, 141, 141),
                    //   ),
                    // )
                  ),
                ),
              ),
            ),
            const Divider(
              height: 5,
              thickness: 2,
              color: Color.fromARGB(160, 228, 226, 226),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getScreenHeight(5), horizontal: getScreenWidth(8)),
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
            LocationListTile(
              press: () {},
              location: "Kabarak, Nakuru, Kenya",
            ),
            Container(),
            SizedBox(height: getScreenHeight(20)),
            Text(
              "Select Payment Method",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: getScreenWidth(15),
                  color: appPrimaryColor),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
              child: Row(children: <Widget>[
                Checkbox(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  value: mPesa,
                  onChanged: (value) {
                    setState(() {
                      mPesa = value!;
                      cash = false;
                    });
                  },
                ),
                Text(
                  "Mpesa Transaction",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getScreenWidth(14)),
                ),
                SizedBox(width: getScreenWidth(25)),
                Checkbox(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  value: cash,
                  onChanged: (value) {
                    setState(() {
                      mPesa = false;
                      cash = value!;
                    });
                  },
                ),
                Text(
                  "Cash Money",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getScreenWidth(14)),
                ),
              ]),
            ),
            SizedBox(height: getScreenHeight(15)),
            mPesa
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: getScreenHeight(70),
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: getScreenHeight(5),
                                  bottom: getScreenHeight(5),
                                  left: getScreenWidth(20)),
                              labelText: "Enter Your Mpesa Number",
                              prefixText: '+254',
                              labelStyle: TextStyle(
                                  fontSize: getScreenWidth(14),
                                  fontWeight: FontWeight.w600),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: appPrimaryColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: appPrimaryColor)),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 9,
                            onChanged: (value) {
                              setState(() {
                                _mpesaNumber = '254$value';
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: getScreenWidth(60),
                              right: getScreenWidth(60),
                              top: getScreenHeight(10),
                              bottom: getScreenHeight(10)),
                          child: DefaultButton(
                            pressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const QRScanScreen1()));
                            },
                            text: "Continue to Payment",
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
                  ),
            cash
                ? Column(
                    children: [
                      Text("!! Ensure you pay your cash before alighting !!",
                          style: TextStyle(
                            fontSize: getScreenWidth(16),
                            color: Colors.red,
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            left: getScreenWidth(100),
                            right: getScreenWidth(100),
                            top: getScreenHeight(35),
                            bottom: getScreenHeight(10)),
                        child: DefaultButton(
                          pressed: () {},
                          text: "Finish",
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Container commonLocations(location) {
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
        child: Text(location,
            style: TextStyle(
                fontSize: getScreenWidth(12), fontWeight: FontWeight.w600)),
      ),
    );
  }
}
