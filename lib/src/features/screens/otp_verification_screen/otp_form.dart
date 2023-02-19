import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../size_config/size_config.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        verificationInput(context),
        verificationInput(context),
        verificationInput(context),
        verificationInput(context),
      ],
    );
  }

  SizedBox verificationInput(BuildContext context) {
    return SizedBox(
      height: getScreenHeight(68),
      width: getScreenWidth(64),
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
