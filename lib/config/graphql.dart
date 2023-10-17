import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlConfiguration {
  static final HttpLink httpLink = HttpLink(
    'http://172.17.17.123:3332/graphql',
  );

  static GraphQLClient initializeApi(String? token) {
    if (token != null) {
      final AuthLink authLink = AuthLink(
        getToken: () async => 'Bearer $token',
        // OR
        // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
      );

      final Link link = authLink.concat(httpLink);
      GraphQLClient graphQLClient =
          GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore()));
      return graphQLClient;
    } else {
      GraphQLClient graphQLClient = GraphQLClient(
          link: httpLink, cache: GraphQLCache(store: HiveStore()));
      return graphQLClient;
    }
  }
}
