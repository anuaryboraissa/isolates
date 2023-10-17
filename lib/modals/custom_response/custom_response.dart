import 'insert_user.dart';

class CustomResponse {
  InsertUser? insertUser;

  CustomResponse({this.insertUser});

  factory CustomResponse.fromJson(Map<String, dynamic> json) {
    return CustomResponse(
      insertUser: json['insertUser'] == null
          ? null
          : InsertUser.fromJson(json['insertUser'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'insertUser': insertUser?.toJson(),
      };
}
