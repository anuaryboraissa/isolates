import 'dart:async';
import 'dart:isolate';

import 'package:dic/modals/custom_response/custom_response.dart';
import 'package:dic/modals/login_user/login_user.dart';
import 'package:dic/operations/mutations.dart';
import 'package:dic/sessions/sessions.dart';
import 'package:dic/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final class LoginProvider extends ChangeNotifier {
  //setters
  String token = "";
  String refreshToken = "";
  String username = "";
  String message = "";
  bool success = false;

  //register
  String registeredMessage = "";
  bool registered = false;

  //getters
  String get userAccessToken => token;
  String get userRefreshToken => refreshToken;
  String get loginUserName => username;
  String get loginMessage => message;
  bool get loginSuccess => success;

  //register getters
  String get userRegisteredMessage => registeredMessage;
  bool get userRegistered => registered;

  //operations
  void login(String userName, String password) async {
    LoginUser? loginUser = await MutationServices.login(userName, password);
    if (loginUser != null && loginUser.login != null) {
      token = loginUser.login!.accessToken.toString();
      refreshToken = loginUser.login!.refreshToken.toString();
      username = loginUser.login!.loginAs.toString();
      message = loginUser.login!.message.toString();
      success = loginUser.login!.success!;
    } else {
      token = "";
      refreshToken = "";
      username = "";
      message = "something went wrong";
      success = false;
    }
    notifyListeners();
  }

  void registerUser(
      String userName, String password, String deviceToken) async {
    CustomResponse? customResponse =
        await MutationServices.registerUser(userName, password, deviceToken);
    if (customResponse != null) {
      registeredMessage = customResponse.insertUser!.message.toString();
      registered = customResponse.insertUser!.success!;
    }
    notifyListeners();
  }
}
