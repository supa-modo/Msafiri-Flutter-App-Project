import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class MpesaFun extends StatefulWidget {
  const MpesaFun({super.key});

  @override
  State<MpesaFun> createState() => _MpesaFunState();
}

class _MpesaFunState extends State<MpesaFun> {
  String _mpesaNumber = '';
  double _amount = 0;
  String partyB = '';
  bool _initialized = false;
  bool _error = false;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
