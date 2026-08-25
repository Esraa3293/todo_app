import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';

class EditTaskProvider extends ChangeNotifier {
  TextEditingController titleController;
  TextEditingController descController;
  TaskModel task;
  late DateTime date;

  EditTaskProvider(this.task)
    : titleController = TextEditingController(text: task.title),
      descController = TextEditingController(text: task.description) {
    date = DateTime.fromMillisecondsSinceEpoch(task.date);
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  Future<void> changeDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.fromMillisecondsSinceEpoch(task.date),
      firstDate: DateTime.fromMillisecondsSinceEpoch(task.date),
      lastDate: DateTime.now().add(Duration(days: 365 * 3)),
    );
    if (selectedDate != null) {
      task.date = selectedDate.millisecondsSinceEpoch;
      notifyListeners();
    }
  }
}
