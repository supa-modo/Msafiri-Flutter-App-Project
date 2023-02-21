import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:project_x/src/services/auth_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get Instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phoneNumber = TextEditingController();

  void registerUser(String email, String password) {
    Auth_repository.instance.createUserWithEmailAndPassword(email, password);
  }
}
