import 'package:flutter/material.dart';

import '../size_config/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.pressed,
  }) : super(key: key);
  final String? text;
  final VoidCallback? pressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getScreenHeight(45),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 50, 130, 250)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
        ),
        onPressed: pressed,
        child: Text(text!,
            style: TextStyle(
              fontSize: getScreenWidth(16),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ),
    );
  }
}
