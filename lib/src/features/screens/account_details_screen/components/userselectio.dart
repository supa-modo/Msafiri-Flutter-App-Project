import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserTypeSelectionDialog extends StatefulWidget {
  final String userType;

  const UserTypeSelectionDialog({Key? key, required this.userType})
      : super(key: key);

  @override
  _UserTypeSelectionDialogState createState() =>
      _UserTypeSelectionDialogState();
}

class _UserTypeSelectionDialogState extends State<UserTypeSelectionDialog> {
  late String updatedUserType;

  @override
  void initState() {
    super.initState();
    updatedUserType = widget.userType;
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return AlertDialog(
      title: Text('Select your user type'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RadioListTile<String>(
            title: Text('Operator'),
            value: 'operator',
            groupValue: updatedUserType,
            onChanged: (value) {
              setState(() {
                updatedUserType = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('Passenger'),
            value: 'passenger',
            groupValue: updatedUserType,
            onChanged: (value) {
              setState(() {
                updatedUserType = value!;
              });
            },
          ),
        ],
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
                'isOperator': updatedUserType,
              },
            );
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
