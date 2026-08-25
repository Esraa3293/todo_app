import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/home_layout/home_layout.dart';
import 'package:todo/providers/auth_service.dart';
import 'package:todo/screens/create_account.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login";
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Theme.of(context).colorScheme.onPrimary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Image.asset(
                            "assets/images/login_bg.png", fit: BoxFit.fill),
                        SizedBox(height: 4.h),
                        Text(
                          context.tr('login'),
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .primary,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(label: Text(
                              context.tr('emailAddress'))),
                          keyboardType: TextInputType.emailAddress,
                          style: Theme
                              .of(context)
                              .textTheme
                              .displayMedium,
                          cursorColor: Theme
                              .of(context)
                              .colorScheme
                              .primary,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email";
                            }
                            bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(value);
                            if (!emailValid) {
                              return "Please enter valid email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(label: Text(
                              context.tr('password'))),
                          style: Theme
                              .of(context)
                              .textTheme
                              .displayMedium,
                          cursorColor: Theme
                              .of(context)
                              .colorScheme
                              .primary,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter password";
                            }
                            if (value.length < 6) {
                              return "Please enter at least 6 characters";
                            }
                            bool passwordValid = RegExp(
                              r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$",
                            ).hasMatch(value);
                            if (!passwordValid) {
                              return "Please enter valid password";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await FirebaseFunctions.login(
                                emailController.text,
                                passwordController.text,
                                    (user) {
                                  Provider.of<AuthService>(
                                    context,
                                    listen: false,
                                  ).updateUser(user);
                                  Navigator.pushReplacementNamed(
                                    context,
                                    HomeLayout.routeName,
                                  );
                                },
                                    (value) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) =>
                                        AlertDialog(
                                          title: Text("Error"),
                                          content: Text(value),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Ok"),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                              );
                            }
                          },
                          child: Text(context.tr('login')),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    context.tr('dontHaveAnAccount?'),
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodySmall,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        CreateAccount.routeName,
                      );
                    },
                    child: Text(
                      context.tr('createAccount'),
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
