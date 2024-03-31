import 'package:flutter/material.dart';
import 'package:flutter_blogger/widgets/settings_header.dart';
import 'package:flutter_blogger/widgets/theme_switch.dart';
import 'package:flutter_blogger/widgets/user_info_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Profile'),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
          child: Column(
            children: <Widget>[
              // user info card
              UserInfoCard(),

              SizedBox(
                height: 20,
              ),

              // settings header
              SettingsHeader(title: 'Settings'),

              SizedBox(
                height: 20,
              ),

              // theme switch
              ThemeSwitch(),
            ],
          ),
        ));
  }
}
