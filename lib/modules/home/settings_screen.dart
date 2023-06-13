import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programming_hacks/app_theme/constant.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_bloc.dart';
import 'package:programming_hacks/widgets/glassmorphic_container.dart';
import 'package:programming_hacks/widgets/rounded_blur_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isNotification = true;
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    _loadNotificationState();
  }

  Future<void> _loadNotificationState() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      isNotification = preferences.getBool('notification_enabled') ?? true;
    });
  }

  Future<void> _saveNotificationState(bool enabled) async {
    setState(() {
      isNotification = enabled;
    });
    await preferences.setBool('notification_enabled', enabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
            _loadNotificationState();
          },
        ),
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          RoundedBlurContainer(
            right: 30,
            top: 50,
            color: Colors.greenAccent.withOpacity(0.4),
          ),
          RoundedBlurContainer(
            left: -100,
            bottom: 400,
            color: Colors.pinkAccent.withOpacity(0.4),
          ),
          RoundedBlurContainer(
            right: -50,
            bottom: 200,
            color: Colors.greenAccent.withOpacity(0.4),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SafeArea(
                child: Column(
                  children: [
                    GlassMorphismContainer(
                      width: 400,
                      height: 70,
                      blur: 10,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Text(
                                    "Notification",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                              StatefulBuilder(
                                builder: (BuildContext context, void Function(void Function()) setState) {
                                  return Switch(
                                    focusColor: Colors.white,
                                    value: isNotification,
                                    onChanged: (value) {
                                      _saveNotificationState(value);
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sSizedBoxHeight,
                    ),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<AuthUserBloc>(context).add(UserLogoutEvent());
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/loginScreen',
                          (route) => false,
                        );
                      },
                      child: GlassMorphismContainer(
                        width: 400,
                        height: 70,
                        blur: 10,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  "Logout",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
