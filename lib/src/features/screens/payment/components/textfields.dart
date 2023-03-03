import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../size_config/size_config.dart';

InputDecoration tillNoTextField() {
  return InputDecoration(
    contentPadding: const EdgeInsets.only(top: 9, bottom: 9, left: 20),
    labelText: "Enter Till Number",
    labelStyle:
        TextStyle(fontSize: getScreenWidth(14), fontWeight: FontWeight.w600),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: appPrimaryColor)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: appPrimaryColor)),
  );
}

InputDecoration accNoTextField() {
  return InputDecoration(
    contentPadding: const EdgeInsets.only(top: 9, bottom: 9, left: 20),
    labelText: "Enter Account Number",
    labelStyle:
        TextStyle(fontSize: getScreenWidth(14), fontWeight: FontWeight.w600),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: appPrimaryColor)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: appPrimaryColor)),
  );
}

InputDecoration paybillTextField() {
  return InputDecoration(
    contentPadding: const EdgeInsets.only(top: 9, bottom: 9, left: 20),
    labelText: "Enter Paybill Number",
    labelStyle:
        TextStyle(fontSize: getScreenWidth(14), fontWeight: FontWeight.w600),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: appPrimaryColor)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: appPrimaryColor)),
  );
}

InputDecoration phoneTextField() {
  return InputDecoration(
    prefixText: '254',
    contentPadding: const EdgeInsets.only(top: 9, bottom: 9, left: 20),
    labelText: "Enter Phone Number",
    labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: appPrimaryColor)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: appPrimaryColor)),
  );
}

TextStyle visibilityText() {
  return TextStyle(
      fontSize: getScreenWidth(13.5), color: Color.fromARGB(255, 255, 38, 23));
}
