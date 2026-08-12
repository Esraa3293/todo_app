import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/home_layout/home_layout.dart';
import 'package:todo/providers/auth_service.dart';
import 'package:todo/providers/settings_provider.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/screens/create_account.dart';
import 'package:todo/screens/edit_task.dart';
import 'package:todo/screens/login.dart';
import 'package:todo/screens/splash_screen.dart';
import 'package:todo/shared/styles/my_theme.dart';
import 'package:todo/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  SharedPrefs.prefs = await SharedPreferences.getInstance();
  // await SharedPrefs.init();
  // await FirebaseFirestore.instance.disableNetwork();
  var provider = AuthService();
  await provider.initUser();
  const fatalError = true;
  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => provider),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()..init()),
      ],
      child: EasyLocalization(
        supportedLocales: [Locale("en"), Locale("ar")],
        path: 'assets/translations',
        fallbackLocale: Locale("en"),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
    var settingsProvider = Provider.of<SettingsProvider>(context);

    // String loggedState = SharedPrefs.getLogin();
    return ScreenUtilInit(
      designSize: Size(412, 870),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
          themeMode: settingsProvider.mode,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          initialRoute: SplashScreen.routeName,
          // isLoggedIn
          //     ? HomeLayout.routeName
          //     : LoginScreen.routeName,
          // loggedState == "logged"
          //     ? HomeLayout.routeName :
          // LoginScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => SplashScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            CreateAccount.routeName: (context) => CreateAccount(),
            HomeLayout.routeName: (context9) => HomeLayout(),
            EditTaskScreen.routeName: (context) => EditTaskScreen(),
          },
        );
      },
    );
  }
}
