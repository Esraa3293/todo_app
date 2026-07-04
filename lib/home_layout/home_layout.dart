import 'package:flutter/material.dart';
import 'package:todo/screens/settings.dart';
import 'package:todo/screens/tasks.dart';
import 'package:todo/screens/widgets/add_task_bottom_sheet.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "homeLayout";

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<Widget> tabs = [TasksTab(), SettingsTab()];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("Todo App", style: Theme.of(context).textTheme.bodyLarge),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (value) {
            index = value;
            setState(() {});
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.list), label: ''),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              label: '',
            ),
          ],
        ),
      ),
      body: tabs[index],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskSheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void showAddTaskSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddTaskBottomSheet(),
        );
      },
    );
  }
}
