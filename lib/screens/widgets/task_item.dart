import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/screens/edit_task.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/app_colors.dart';

class TaskItem extends StatelessWidget {
  final TaskModel taskModel;

  const TaskItem({required this.taskModel, super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskProvider>(context);

    return Card(
      child: Slidable(
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: context.tr('delete'),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              onPressed: (context) {
                provider.deleteTask(taskModel.id);
              },
            ),
            SlidableAction(
              backgroundColor: Colors.blue,
              icon: Icons.edit,
              label: context.tr('edit'),
              onPressed: (context) {
                Navigator.pushNamed(
                  context,
                  EditTaskScreen.routeName,
                  arguments: taskModel,
                );
              },
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 5,
                color: taskModel.status
                    ? AppColors.greenColor
                    : AppColors.primaryColor,
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskModel.title,
                      style: taskModel.status
                          ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.greenColor,
                            )
                          : Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      taskModel.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Spacer(),
              taskModel.status
                  ? Text(
                'done',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.greenColor,
                      ),
              ).tr()
                  : InkWell(
                      onTap: () {
                        taskModel.status = true;
                        FirebaseFunctions.updateTask(taskModel.id, taskModel);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor,
                        ),
                        child: Icon(Icons.done),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
