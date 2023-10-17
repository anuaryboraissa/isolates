class InsertUser {
  bool? success;
  String? message;

  InsertUser({this.success, this.message});

  factory InsertUser.fromJson(Map<String, dynamic> json) => InsertUser(
        success: json['success'] as bool?,
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };
}
