import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/home_layout/home_layout.dart';
import 'package:todo/screens/login.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initSplash();
    super.initState();
  }

  Future<void> initSplash() async {
    await Future.delayed(Duration(seconds: 2));

    if (!mounted) return;

    bool isLoggedIn = FirebaseAuth.instance.currentUser != null;

    isLoggedIn
        ? Navigator.pushReplacementNamed(context, HomeLayout.routeName)
        : Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Center(
              child: Image.asset(
                "assets/images/splash_logo.png",
                width: 150.w,
                height: 150.h,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Image.asset(
                "assets/images/splash_copyright.png",
                width: 120.w,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
