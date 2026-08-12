import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/home_layout/home_layout.dart';
import 'package:todo/providers/auth_service.dart';
import 'package:todo/screens/login.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/app_colors.dart';

class CreateAccount extends StatelessWidget {
  static const String routeName = "createAccount";
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/registration_bg.png",
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(label: Text("Name")),
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black54),
                    cursorColor: AppColors.primaryColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: ageController,
                    decoration: InputDecoration(label: Text("Age")),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black54),
                    cursorColor: AppColors.primaryColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter age";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(label: Text("Email address")),
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black54),
                    cursorColor: AppColors.primaryColor,
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
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(label: Text("Password")),
                    style: TextStyle(color: Colors.black54),
                    cursorColor: AppColors.primaryColor,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      }
                      if (value.length < 6) {
                        return "Please enter at  least 6 characters";
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
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await FirebaseFunctions.createAccount(
                          nameController.text,
                          int.parse(ageController.text),
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
                        );
                      }
                    },
                    child: Text("Submit"),
                  ),
                  Row(
                    children: [
                      Text(
                        "Have an account?",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            LoginScreen.routeName,
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
