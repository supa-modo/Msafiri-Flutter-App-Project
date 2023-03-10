import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/src/features/models/user_models.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> createUser(UserModel user) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      Get.snackbar('Error', 'Not logged in.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red,
          duration: Duration(seconds: 3));
      return;
    }

    return await _db
        .collection("users")
        .doc(uid)
        .set(user.toJson())
        .whenComplete(() => Get.snackbar(
              'Success',
              'Your account has been created.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.2),
              colorText: Colors.green,
              duration: Duration(seconds: 3),
            ))
        .catchError((error, stackTrace) {
      Get.snackbar('Error', 'Something went wrong, try again',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red,
          duration: Duration(seconds: 3));
      print(error.toString());
    });
  }
}
