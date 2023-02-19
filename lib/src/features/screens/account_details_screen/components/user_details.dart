import 'package:flutter/material.dart';

import '../../../../size_config/size_config.dart';
import 'edit_text.dart';

class change_password extends StatelessWidget {
  const change_password({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                size: getScreenWidth(26),
                Icons.lock,
                color: Colors.grey,
              ),
              SizedBox(width: getScreenWidth(10)),
              Text("Change Account Password",
                  // _user.displayName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getScreenWidth(14),
                      color: const Color.fromARGB(255, 80, 79, 79))),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Color.fromARGB(255, 119, 119, 119),
          ),
        ],
      ),
    );
  }
}

class user_phone extends StatelessWidget {
  const user_phone({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              size: getScreenWidth(26),
              Icons.phone,
              color: Colors.grey,
            ),
            SizedBox(width: getScreenWidth(10)),
            Text("User Phone number",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getScreenWidth(14),
                    color: const Color.fromARGB(255, 80, 79, 79))),
          ],
        ),
        TextButton.icon(
          icon: Icon(Icons.edit, size: getScreenWidth(18)),
          label: edit_text(),
          onPressed: () {
            // handle edit button press
          },
        ),
      ],
    );
  }
}

class user_email extends StatelessWidget {
  const user_email({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              size: getScreenWidth(25),
              Icons.mail,
              color: Colors.grey,
            ),
            SizedBox(width: getScreenWidth(10)),
            Text("User Account email",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getScreenWidth(14),
                    color: const Color.fromARGB(255, 80, 79, 79))),
          ],
        ),
        TextButton.icon(
          icon: Icon(Icons.edit, size: getScreenWidth(18)),
          label: edit_text(),
          onPressed: () {
            // handle edit button press
          },
        ),
      ],
    );
  }
}

class user_name extends StatelessWidget {
  const user_name({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              size: getScreenWidth(32),
              Icons.account_circle,
              color: Colors.grey,
            ),
            SizedBox(width: getScreenWidth(10)),
            Text("User Account Name",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getScreenWidth(14),
                    color: const Color.fromARGB(255, 80, 79, 79))),
          ],
        ),
        TextButton.icon(
          icon: Icon(Icons.edit, size: getScreenWidth(18)),
          label: edit_text(),
          onPressed: () {
            // handle edit button press
          },
        ),
      ],
    );
  }
}
