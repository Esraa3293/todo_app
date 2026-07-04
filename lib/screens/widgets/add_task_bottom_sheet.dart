import 'package:flutter/material.dart';
import 'package:todo/shared/styles/app_colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  String selectedDate = DateTime.now().toString().substring(0, 10);

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
                  selectedDate,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    print("task added");
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
      lastDate: DateTime.now().add(Duration(days: 3)),
    );
    if (selected != null) {
      selectedDate = selected.toString().substring(0, 10);
      setState(() {});
    }
  }
}
