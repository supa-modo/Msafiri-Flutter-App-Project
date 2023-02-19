import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../common_widgets/back_home_button.dart';
import '../../../common_widgets/logout_button.dart';
import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';
import 'components/user_details.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = false;
  void _saveDarkModeSetting(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  @override
  void initState() {
    super.initState();
    _loadDarkModeSetting();
  }

  void _loadDarkModeSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkModeEnabled = prefs.getBool('isDarkMode') ?? false;
    setState(() {
      isDarkMode = isDarkModeEnabled;
    });
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
          child: Column(
            children: <Widget>[
              Container(
                // margin: EdgeInsets.only(top: getScreenHeight(100)),
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: getScreenWidth(70),
                      backgroundColor: const Color.fromARGB(255, 204, 203, 203),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: getScreenWidth(90),
                      top: getScreenHeight(85),
                      child: TextButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.camera_alt,
                            color: appPrimaryColor,
                            size: getScreenWidth(44),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(height: getScreenHeight(50)),
              Column(
                children: <Widget>[
                  user_name(),
                  const Divider(
                    thickness: 1,
                  ),
                  user_email(),
                  const Divider(
                    thickness: 1,
                  ),
                  user_phone(),
                  const Divider(
                    thickness: 1,
                  ),
                  change_password(),
                  const Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: getScreenHeight(10),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getScreenWidth(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.light_mode,
                              size: getScreenWidth(28),
                            ),
                            SizedBox(width: getScreenWidth(20)),
                            Text(
                              "Dark Mode",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: getScreenWidth(16),
                                  color: Color.fromARGB(230, 61, 60, 60)),
                            ),
                          ],
                        ),
                        Switch(
                            value: isDarkMode,
                            onChanged: (value) {
                              setState(() {
                                isDarkMode = value;
                                Get.changeThemeMode(isDarkMode
                                    ? ThemeMode.dark
                                    : ThemeMode.light);
                                _saveDarkModeSetting(isDarkMode);
                              });
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: getScreenHeight(30)),
                  logout_button(),
                  SizedBox(height: getScreenHeight(30)),
                  back_home_button(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
