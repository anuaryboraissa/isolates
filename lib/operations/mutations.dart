import 'package:dic/config/graphql.dart';
import 'package:dic/modals/custom_response/custom_response.dart';
import 'package:dic/modals/login_user/login_user.dart';
import 'package:dic/operations/operations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MutationServices {
  static Future<LoginUser?> login(String userName, String password) async {
    print("test login.............");
    GraphQLClient client = GraphQlConfiguration.initializeApi(null);
    QueryResult result = await client.query(QueryOptions(
        variables: {"username": userName, "password": password},
        document: gql(OperationServices.login)));
    if (result.hasException) {
      print("an error ${result.exception}.............");
      return null;
    } else if (!result.hasException) {
      print("success.............");
      Map<String, dynamic>? data = result.data;
      print("lofin user $data");
      LoginUser loginUser = LoginUser.fromMap(data!);
      print("success.............${loginUser.login!.accessToken}");
      return loginUser;
    }
    return null;
  }

  static Future<CustomResponse?> registerUser(
      String userName, String password, String devicesToken) async {
    print("test login.............");
    GraphQLClient client = GraphQlConfiguration.initializeApi(null);
    QueryResult result = await client.query(QueryOptions(variables: {
      "username": userName,
      "password": password,
      "deviceToken": devicesToken
    }, document: gql(OperationServices.registerUser)));
    print("check something here.............");
    if (result.hasException) {
      print("an error ${result.exception}.............");
      return null;
    } else if (!result.hasException) {
      print("success.............");
      Map<String, dynamic>? data = result.data;
      print(" user $data");
      CustomResponse customResponse = CustomResponse.fromJson(data!);
      print("success.............${customResponse.insertUser!.message}");
      return customResponse;
    }
    return null;
  }
}
