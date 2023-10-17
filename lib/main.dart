import 'package:dic/screens/dashboard/landing_page.dart';
import 'package:dic/stateManagement/login_provider.dart';
import 'package:dic/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'stateManagement/async.dart';

void main() async {
  await initHiveForFlutter();
  runApp(const DICApplication());
}

class DICApplication extends StatefulWidget {
  const DICApplication({super.key});

  @override
  State<DICApplication> createState() => _DICApplicationState();
}

class _DICApplicationState extends State<DICApplication> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<ConditionNotifier>(
          create: (context) => ConditionNotifier(),
        )
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: AppRoutes.routes,
          initialRoute: AppRoutes.home,
          onGenerateRoute: (settings) {
            print("this is ");
            if (settings.name == AppRoutes.landingPage) {
              String userName = settings.arguments as String;
              print("this is $userName");
              return MaterialPageRoute(
                builder: (context) => LandingPage(username: userName),
              );
            }
            return null;
          },
        );
      }),
    );
  }
}
