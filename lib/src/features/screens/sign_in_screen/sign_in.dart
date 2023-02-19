import 'package:flutter/material.dart';

import '../../../size_config/size_config.dart';
import 'body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(),
      body: const Body(),
    );
  }
}
