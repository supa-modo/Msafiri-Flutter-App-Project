import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_x/src/features/screens/new_trip/place_autocompl.dart';

import '../../../../size_config/size_config.dart';
import 'dots_indicator.dart';
import 'mpesa_demo.dart';
import 'my_account.dart';
import 'new_trip.dart';
import 'payment.dart';
import 'payment_list.dart';
import 'view_map.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

List<Map<String, String>> carouselItems = [
  {
    'imagePath': "assets/images/transparency.png",
    'text': "Multi-factor authentication for enhanced Security"
  },
  {
    'imagePath': "assets/images/flawlessPayment.png",
    'text': "Easy and fast payments"
  },
  {
    'imagePath': "assets/images/gpsDirection.jpeg",
    'text': "Live location gps tracking to your destination"
  },
  {
    'imagePath': "assets/images/qrScan.png",
    'text': "Scan and make payments in seconds"
  },
  {
    'imagePath': "assets/images/invoice.jpg",
    'text': "Monitor real-time payments made to your account"
  },
];

class _BodyState extends State<Body> {
  CarouselController carouselController = CarouselController();
  var currentPageValue = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getScreenHeight(263),
              child: Column(
                children: <Widget>[
                  CarouselSlider(
                    items: carouselItems.map((item) {
                      return Stack(children: [
                        Container(
                            height: getScreenHeight(232),
                            margin: EdgeInsets.only(
                                top: getScreenHeight(10),
                                bottom: getScreenHeight(10)),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(item['imagePath']!)),
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                            )),
                        Positioned(
                          bottom: getScreenHeight(25),
                          left: getScreenWidth(10),
                          child: SizedBox(
                            width: getScreenWidth(200),
                            child: Text(item['text']!,
                                softWrap: true,
                                style: TextStyle(
                                    color: Color.fromARGB(225, 12, 25, 31),
                                    fontSize: getScreenWidth(23),
                                    fontWeight: FontWeight.w900)),
                          ),
                        ),
                      ]);
                    }).toList(),
                    options: CarouselOptions(
                      initialPage: 0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 6),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.82,
                      aspectRatio: 2.0,
                      height: getScreenHeight(240),
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentPageValue = index;
                        });
                      },
                    ),
                    carouselController: carouselController,
                  ),

                  dots_indicator(currentPageValue: currentPageValue),
                  // ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color.fromARGB(225, 37, 36, 36)
                      : Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              height: getScreenHeight(590),
              child: Padding(
                padding: EdgeInsets.only(
                    left: getScreenWidth(5),
                    right: getScreenWidth(5),
                    bottom: getScreenHeight(5)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        newTrip(),
                        payment(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        view_map(),
                        my_account(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        payment_list(),
                        mpesa_demo(),
                        // LocationSearch(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
