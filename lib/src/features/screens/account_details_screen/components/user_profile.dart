import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../size_config/size_config.dart';
import 'edit_text.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String userName = 'Not available';

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    userName = user?.displayName ?? 'Not available';
  }

  void updateUserName(String newName) {
    setState(() {
      userName = newName;
    });
  }

  void _showUpdateUserNameDialog() {
    User? user = FirebaseAuth.instance.currentUser;
    String updatedName = userName;
    showDialog(
      context: context,
      builder: (context) {
        return UpdateUserNameDialog(
          initialName: userName,
          onUpdate: (newName) {
            updatedName = newName;
            FirebaseAuth.instance.currentUser?.updateDisplayName(updatedName);
            FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
              'name': updatedName,
            });
            updateUserName(updatedName);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
          onPressed: _showUpdateUserNameDialog,
        ),
      ],
    );
  }
}

class UpdateUserNameDialog extends StatefulWidget {
  final String initialName;
  final Function(String) onUpdate;

  const UpdateUserNameDialog({
    Key? key,
    required this.initialName,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _UpdateUserNameDialogState createState() => _UpdateUserNameDialogState();
}

class _UpdateUserNameDialogState extends State<UpdateUserNameDialog> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter your new name'),
      content: TextField(
        controller: _nameController,
        decoration: InputDecoration(hintText: widget.initialName),
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
          onPressed: () {
            widget.onUpdate(_nameController.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
