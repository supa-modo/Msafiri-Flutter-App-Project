import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../size_config/size_config.dart';
import 'edit_text.dart';
import 'userselectio.dart';

class UserTypeSelection extends StatelessWidget {
  const UserTypeSelection({
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
        String userType = userData != null && userData.containsKey('isOperator')
            ? userData['isOperator']
            : 'not set';
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  size: getScreenWidth(26),
                  Icons.verified_user_outlined,
                  color: Colors.grey,
                ),
                SizedBox(width: getScreenWidth(10)),
                Text('User Type - $userType',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getScreenWidth(14),
                        color: Color.fromARGB(255, 100, 123, 173))),
              ],
            ),
            TextButton.icon(
              icon: Icon(Icons.edit, size: getScreenWidth(18)),
              label: edit_text(),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return UserTypeSelectionDialog(userType: userType);
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
