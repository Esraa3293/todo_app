import 'package:flutter/material.dart';

class HomeLayout extends StatelessWidget {
  static const String routeName = "homeLayout";

  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App", style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}
