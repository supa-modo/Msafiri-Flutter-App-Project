import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../size_config/size_config.dart';
import 'edit_text.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
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
        String userName = userData != null && userData.containsKey('fullName')
            ? userData['fullName']
            : 'Not available';
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  size: getScreenWidth(25),
                  Icons.person,
                  color: Colors.grey,
                ),
                SizedBox(width: getScreenWidth(10)),
                Text(userName,
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
                    return UpdateUserNameDialog(userName: userName);
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

class UpdateUserNameDialog extends StatefulWidget {
  final String userName;

  const UpdateUserNameDialog({Key? key, required this.userName})
      : super(key: key);

  @override
  _UpdateUserNameDialogState createState() => _UpdateUserNameDialogState();
}

class _UpdateUserNameDialogState extends State<UpdateUserNameDialog> {
  late String updatedUserName;

  @override
  void initState() {
    super.initState();
    updatedUserName = widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return AlertDialog(
      title: Text('Enter your new name'),
      content: TextField(
        decoration: InputDecoration(hintText: widget.userName),
        onChanged: (value) {
          setState(() {
            updatedUserName = value;
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
                'fullName': updatedUserName,
              },
            );
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
