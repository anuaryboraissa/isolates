import 'dart:convert';

import 'login.dart';

class LoginUser {
  Login? login;

  LoginUser({this.login});

  factory LoginUser.fromMap(Map<String, dynamic> data) => LoginUser(
        login: data['login'] == null
            ? null
            : Login.fromMap(data['login'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'login': login?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginUser].
  factory LoginUser.fromJson(String data) {
    return LoginUser.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginUser] to a JSON string.
  String toJson() => json.encode(toMap());
}
