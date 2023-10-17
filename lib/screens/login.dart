import 'package:dic/sessions/sessions.dart';
import 'package:dic/stateManagement/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../utils/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  bool called = false;
  bool attempt = false;
  SessionManager sessionManager = SessionManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Consumer<LoginProvider>(
          builder: (context, loginProvider, _) {
            if (loginProvider.loginSuccess && attempt) {
              print(
                  "login access ${loginProvider.userAccessToken} ${loginProvider.loginUserName}");

              WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                await sessionManager
                    .setAccessToken(loginProvider.userAccessToken);
                await sessionManager
                    .setRefreshToken(loginProvider.userRefreshToken);
                await sessionManager
                    .setLoginUserName(loginProvider.loginUserName);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacementNamed(
                    AppRoutes.landingPage,
                    arguments: loginProvider.loginUserName);
              });
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Welcome Back!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: userName,
                    decoration: const InputDecoration(label: Text("Username")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    controller: password,
                    decoration: const InputDecoration(label: Text("password")),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          if (userName.text.isNotEmpty &&
                              password.text.isNotEmpty) {
                            setState(() {
                              attempt = true;
                            });
                            loginProvider.login(userName.text, password.text);
                            Fluttertoast.showToast(
                                msg: "Message ${loginProvider.loginMessage}");
                          }
                        },
                        child: attempt && loginProvider.loginMessage.isEmpty
                            ? const CircularProgressIndicator()
                            : const Text("Sign In!")),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account ?"),
                        const SizedBox(
                          width: 4,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(AppRoutes.register);
                            },
                            child: const Text("Sign Up"))
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      )),
    );
  }
}
