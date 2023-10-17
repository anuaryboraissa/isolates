import 'package:dic/stateManagement/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../utils/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeatPassword = TextEditingController();
  bool attemptRegister = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Consumer<LoginProvider>(builder: (context, loginProvider, _) {
          if (loginProvider.userRegistered && attemptRegister) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              userName.clear();
              password.clear();
              repeatPassword.clear();
              Fluttertoast.showToast(msg: loginProvider.userRegisteredMessage);
              Navigator.of(context).pushReplacementNamed(AppRoutes.login);
            });
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Create Account",
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
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(label: Text("password")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: repeatPassword,
                  obscureText: true,
                  decoration:
                      const InputDecoration(label: Text("repeat password")),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () {
                        if (userName.text.isNotEmpty &&
                            password.text.isNotEmpty &&
                            repeatPassword.text == password.text) {
                          print("sign up!");
                          setState(() {
                            attemptRegister = true;
                          });
                          loginProvider.registerUser(
                              userName.text,
                              password.text,
                              "hjgsdhwdksacfhjscfhsd,cf<jfhjhd<kjhdfjkhfvdjcfhdjhdl");
                        }
                      },
                      child: const Text("Sign Up!")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have account ?"),
                    const SizedBox(
                      width: 4,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.login);
                        },
                        child: const Text("Sign In"))
                  ],
                ),
              )
            ],
          );
        }),
      )),
    );
  }
}
