import 'dart:convert';

class Login {
  bool? success;
  String? message;
  String? accessToken;
  String? refreshToken;
  String? loginAs;

  Login(
      {this.success,
      this.message,
      this.accessToken,
      this.refreshToken,
      this.loginAs});

  factory Login.fromMap(Map<String, dynamic> data) => Login(
      success: data['success'] as bool?,
      message: data['message'] as String?,
      accessToken: data['accessToken'] as String?,
      refreshToken: data['refreshToken'] as String?,
      loginAs: data['loginAs'] as String?);

  Map<String, dynamic> toMap() => {
        'success': success,
        'message': message,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'loginAs': loginAs
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Login].
  factory Login.fromJson(String data) {
    return Login.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Login] to a JSON string.
  String toJson() => json.encode(toMap());
}
