import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';

class TaskProvider extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late DateTime selectedDate;
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  TaskProvider()
      : formKey = GlobalKey<FormState>(),
        selectedDate = DateUtils.dateOnly(DateTime.now()),
        titleController = TextEditingController(),
        descriptionController = TextEditingController();

  void clearData() {
    titleController.clear();
    descriptionController.clear();
    selectedDate = DateUtils.dateOnly(DateTime.now());
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Stream<QuerySnapshot<TaskModel>> getTasks() {
    return FirebaseFunctions.getTasksFromFireStore(selectedDate);
  }

  Future<void> addTask(TaskModel task) async {
    await FirebaseFunctions.addTasksToFireStore(task);
    clearData();
    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    await FirebaseFunctions.deleteTask(id);
    notifyListeners();
  }

  Future<void> updateTask(TaskModel task) async {
    await FirebaseFunctions.updateTask(task.id, task);
    notifyListeners();
  }

  Future<void> chooseDate(BuildContext context) async {
    DateTime? selected = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 3)),
    );
    if (selected != null) {
      selectedDate = DateUtils.dateOnly(selected);
      notifyListeners();
    }
  }
}
