import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/screens/edit_task.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';

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
                topLeft: Radius.circular(15.r),
                bottomLeft: Radius.circular(15.r),
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
          padding: EdgeInsets.all(16.0.r),
          child: Row(
            children: [
              Container(
                height: 100.h,
                width: 5.w,
                color: taskModel.status
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskModel.title,
                      style: taskModel.status
                          ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
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
                        color: Theme.of(context).colorScheme.secondary,
                      ),
              ).tr()
                  : InkWell(
                      onTap: () {
                        taskModel.status = true;
                        FirebaseFunctions.updateTask(taskModel.id, taskModel);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Theme.of(context).colorScheme.primary,
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
