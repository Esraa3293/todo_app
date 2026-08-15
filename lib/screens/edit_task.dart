import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/edit_task_provider.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/shared/styles/app_colors.dart';

class EditTaskScreen extends StatelessWidget {
  static const String routeName = 'editTaskScreen';

  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var task = ModalRoute.of(context)?.settings.arguments as TaskModel;

    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .brightness == Brightness.light
          ? AppColors.lightGreenColor
          : AppColors.darkBgColor,
      appBar: AppBar(
        title: Text("Todo App", style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChangeNotifierProvider(
              create: (context) => EditTaskProvider(task),
              builder: (context, child) {
                var provider = Provider.of<EditTaskProvider>(context);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Edit Task",
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    TextField(
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      controller: provider.titleController,
                      decoration: InputDecoration(label: Text("Task Title")),
                    ),
                    SizedBox(height: 30.h),
                    TextField(
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      controller: provider.descController,
                      decoration: InputDecoration(
                        label: Text("Task Description"),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Task Date",
                        style: TextStyle(
                          color:
                          Theme
                              .of(context)
                              .brightness == Brightness.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    InkWell(
                      onTap: () {
                        provider.changeDate(context);
                      },
                      child: Text(
                        DateTime.fromMillisecondsSinceEpoch(
                          provider.task.date,
                        ).toString().substring(0, 10),
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        provider.task.title = provider.titleController.text;
                        provider.task.description =
                            provider.descController.text;
                        var taskProvider = Provider.of<TaskProvider>(
                          context,
                          listen: false,
                        );
                        taskProvider.updateTask(provider.task);
                        Navigator.pop(context);
                      },
                      child: Text("Save changes"),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
