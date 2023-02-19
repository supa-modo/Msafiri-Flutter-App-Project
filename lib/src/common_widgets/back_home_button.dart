import 'package:flutter/material.dart';

import '../size_config/size_config.dart';

class back_home_button extends StatelessWidget {
  const back_home_button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getScreenWidth(85)),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(175, 243, 242, 242)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              size: getScreenWidth(28),
              Icons.home,
              color: Color.fromARGB(255, 134, 133, 133),
            ),
            SizedBox(width: getScreenHeight(10)),
            Text("Back Home",
                // _user.displayName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getScreenHeight(15),
                    color: const Color.fromARGB(255, 80, 79, 79))),
            SizedBox(width: getScreenHeight(5)),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 134, 133, 133),
            ),
          ],
        ),
      ),
    );
  }
}
