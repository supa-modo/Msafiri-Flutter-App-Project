import 'package:flutter/material.dart';
import 'package:project_x/src/services/auth_repository.dart';

import '../size_config/size_config.dart';

class logout_button extends StatelessWidget {
  const logout_button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getScreenWidth(30)),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).brightness == Brightness.dark
                  ? Color.fromARGB(179, 37, 36, 36)
                  : const Color.fromARGB(255, 224, 224, 224)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        ),
        onPressed: () {
          AuthRepository.instance.logout();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.exit_to_app, color: Colors.red),
            SizedBox(width: getScreenHeight(10)),
            Text("Logout",
                style:
                    TextStyle(color: Colors.red, fontSize: getScreenWidth(15))),
          ],
        ),
      ),
    );
  }
}
