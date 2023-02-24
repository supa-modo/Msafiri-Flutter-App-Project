import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../size_config/size_config.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getScreenWidth(40)),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          verificationInput(context),
          SizedBox(width: getScreenWidth(10)),
          verificationInput(context),
          SizedBox(width: getScreenWidth(10)),
          verificationInput(context),
          SizedBox(width: getScreenWidth(10)),
          verificationInput(context),
        ],
      ),
    );
  }

  SizedBox verificationInput(BuildContext context) {
    return SizedBox(
      height: getScreenHeight(60),
      width: getScreenWidth(56),
      child: TextFormField(
        // controller: _codeController,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
