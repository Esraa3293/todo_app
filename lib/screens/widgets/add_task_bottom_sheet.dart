import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/shared/styles/app_colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: provider.formKey,
          child: Column(
            children: [
              Text(
                'addNewTask',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                  color: Theme
                      .of(context)
                      .brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
              ).tr(),
              SizedBox(height: 25),
              TextFormField(
                style: Theme.of(context).textTheme.displayMedium,
                controller: provider.titleController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(label: Text('taskTitle').tr()),
                cursorColor: AppColors.primaryColor,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter task title";
                  } else if (value.length < 10) {
                    return "Please enter at least 10 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                style: Theme.of(context).textTheme.displayMedium,
                controller: provider.descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  label: Text('taskDescription').tr(),
                ),
                cursorColor: AppColors.primaryColor,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter task description";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'selectDate',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                    color: Theme
                        .of(context)
                        .brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                ).tr(),
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  provider.chooseDate(context);
                },
                child: Text(
                  provider.selectedDate.toString().substring(0, 10),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (provider.formKey.currentState!.validate()) {
                    TaskModel taskModel = TaskModel(
                      title: provider.titleController.text,
                      description: provider.descriptionController.text,
                      date: provider.selectedDate.millisecondsSinceEpoch,
                      status: false,
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      dateTime: DateTime
                          .now()
                          .millisecondsSinceEpoch,
                    );
                    provider.addTask(taskModel);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text('addTask').tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
