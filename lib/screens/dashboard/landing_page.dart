import 'package:dic/utils/helpers.dart';
import 'package:flutter/material.dart';

import '../../sessions/sessions.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.username});
  final String username;
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  SessionManager sessionManager = SessionManager();
  @override
  void initState() {
    initialize();
    getUserDetails();
    super.initState();
  }

  String accessToken = "";
  String refreshToken = "";
  String userName = "";
  getUserDetails() {
    sessionManager.getAccessToken.then((value) {
      setState(() {
        accessToken = value.toString();
      });
    });
    sessionManager.getLoginUsername.then((value) {
      setState(() {
        userName = value.toString();
      });
    });
    sessionManager.getRefreshToken.then((value) {
      setState(() {
        refreshToken = value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome ${widget.username}"),
            Text("token $refreshToken"),
            Text("refresh $accessToken")
          ],
        ),
      )),
    );
  }
}
