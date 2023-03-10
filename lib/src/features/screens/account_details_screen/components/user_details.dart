import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../size_config/size_config.dart';
import 'edit_text.dart';

class UserEmail extends StatelessWidget {
  const UserEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String userEmail = user?.email ?? 'Not available';
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
            Text(userEmail,
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
            showDialog(
              context: context,
              builder: (context) {
                String updatedEmail = userEmail;
                return AlertDialog(
                  title: Text('Enter your new email address'),
                  content: TextField(
                    onChanged: (value) {
                      updatedEmail = value;
                    },
                    decoration: InputDecoration(hintText: userEmail),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Save'),
                      onPressed: null,
                      // () async {
                      //   await FirebaseAuth.instance.currentUser
                      //       ?.updateEmail(updatedEmail);
                      //   await FirebaseFirestore.instance
                      //       .collection('users')
                      //       .doc(user?.uid)
                      //       .set({
                      //     'email': updatedEmail,
                      //   });
                      //   Navigator.of(context).pop();
                      // },
                    )
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class UserPhone extends StatelessWidget {
  const UserPhone({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .snapshots(),
      initialData: null,
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final userData = snapshot.data!.data();
        String phoneNumber =
            userData != null && userData.containsKey('phoneNumber')
                ? userData['phoneNumber']
                : 'Not available';
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
                Text(phoneNumber,
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
                showDialog(
                  context: context,
                  builder: (context) {
                    return UpdatephoneNumberDialog(phoneNumber: phoneNumber);
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class UpdatephoneNumberDialog extends StatefulWidget {
  final String phoneNumber;

  const UpdatephoneNumberDialog({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  _UpdatephoneNumberDialogState createState() =>
      _UpdatephoneNumberDialogState();
}

class _UpdatephoneNumberDialogState extends State<UpdatephoneNumberDialog> {
  late String updatedphoneNumber;

  @override
  void initState() {
    super.initState();
    updatedphoneNumber = widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return AlertDialog(
      title: Text('Enter your new name'),
      content: TextField(
        decoration: InputDecoration(hintText: widget.phoneNumber),
        onChanged: (value) {
          setState(() {
            updatedphoneNumber = value;
          });
        },
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user?.uid)
                .update(
              {
                'phoneNumber': updatedphoneNumber,
              },
            );
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
