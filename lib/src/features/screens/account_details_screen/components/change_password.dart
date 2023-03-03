import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../size_config/size_config.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Builder(
              builder: (context) {
                return AlertDialog(
                  title: Text('Change Your Password'),
                  content: ChangePasswordForm(user),
                );
              },
            );
          },
        );
      },
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
              Text(
                "Change Account Password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getScreenWidth(14),
                  color: const Color.fromARGB(255, 80, 79, 79),
                ),
              ),
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

class ChangePasswordForm extends StatefulWidget {
  final User? user;

  const ChangePasswordForm(this.user);

  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? _currentPassword;
  String? _newPassword;
  String? _confirmPassword;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        await widget.user!.updatePassword(_newPassword!);
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text('The password provided is too weak.'),
            ),
          );
        } else if (e.code == 'requires-recent-login') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                  'This operation is sensitive and requires recent authentication. Log in again before retrying this request.'),
            ),
          );
        } else if (e.code == 'user-mismatch') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                  'The supplied credentials do not correspond to the previously signed in user.'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                  'An error occurred while trying to update the password.'),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Current Password',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the current password';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _currentPassword = value;
              });
            },
          ),
          SizedBox(height: getScreenHeight(10)),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'New Password',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the new password';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters long';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _newPassword = value;
              });
            },
          ),
          SizedBox(height: getScreenHeight(10)),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm New Password',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm the new password';
              }
              if (value != _newPassword) {
                return 'Passwords do not match';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _confirmPassword = value;
              });
            },
          ),
          SizedBox(height: getScreenHeight(20)),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Change Password'),
          ),
        ],
      ),
    );
  }
}
