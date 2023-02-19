import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../size_config/size_config.dart';
import 'dots_indicator.dart';
import 'mpesa_demo.dart';
import 'my_account.dart';
import 'new_trip.dart';
import 'payment.dart';
import 'payment_list.dart';
import 'view_map.dart';

class Body extends StatefulWidget {
  const Body({super.key});

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
    'imagePath': "assets/images/transactions.png",
    'text': "Still in development"
  },
  {'imagePath': "assets/images/invoice.jpg", 'text': "Still in development"},
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
            // SizedBox(height: SizeConfig.screenHeight! * 0.0005),
            SizedBox(
              height: getScreenHeight(263),
              child: Column(
                children: <Widget>[
                  CarouselSlider(
                    items: carouselItems.map((item) {
                      return Stack(children: [
                        Container(
                            height: getScreenHeight(230),
                            margin: EdgeInsets.only(
                                top: getScreenHeight(10),
                                bottom: getScreenHeight(10)),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(item['imagePath']!)),
                              color: const Color.fromARGB(235, 106, 110, 124),
                              borderRadius: BorderRadius.circular(20),
                            )),
                        Positioned(
                          bottom: getScreenHeight(30),
                          left: getScreenWidth(10),
                          child: SizedBox(
                            width: getScreenWidth(200),
                            child: Text(item['text']!,
                                softWrap: true,
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(199, 17, 31, 37),
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
                      viewportFraction: 0.84,
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
              decoration: const BoxDecoration(
                  color: Colors.white,
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
