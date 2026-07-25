import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/app_colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateUtils.dateOnly(DateTime.now());
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                "Add new task",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Colors.black),
              ),
              SizedBox(height: 25),
              TextFormField(
                style: Theme.of(context).textTheme.displayMedium,
                controller: titleController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(label: Text("Task Title")),
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
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(label: Text("Task Description")),
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
                  "Select Date",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: Colors.black),
                ),
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  chooseDate();
                },
                child: Text(
                  selectedDate.toString().substring(0, 10),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    TaskModel taskModel = TaskModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      date: selectedDate.millisecondsSinceEpoch,
                      status: false,
                    );
                    FirebaseFunctions.addTasksToFireStore(taskModel);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text("Add Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> chooseDate() async {
    DateTime? selected = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 3)),
    );
    if (selected != null) {
      selectedDate = DateUtils.dateOnly(selected);
      setState(() {});
    }
  }
}
