import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/home_layout/home_layout.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/create_account.dart';
import 'package:todo/screens/edit_task.dart';
import 'package:todo/screens/login.dart';
import 'package:todo/shared/styles/my_theme.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await SharedPrefs.init();
  // await FirebaseFirestore.instance.disableNetwork();
  var provider = MyProvider();
  await provider.initUser();

  runApp(ChangeNotifierProvider(create: (context) => provider, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
    // String loggedState = SharedPrefs.getLogin();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: isLoggedIn ? HomeLayout.routeName : LoginScreen.routeName,
      // loggedState == "logged"
      //     ? HomeLayout.routeName :
      // LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        CreateAccount.routeName: (context) => CreateAccount(),
        HomeLayout.routeName: (context9) => HomeLayout(),
        EditTaskScreen.routeName: (context) => EditTaskScreen(),
      },
    );
  }
}
