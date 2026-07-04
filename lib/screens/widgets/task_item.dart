import 'package:flutter/material.dart';
import 'package:todo/shared/styles/app_colors.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(height: 100, width: 5, color: AppColors.primaryColor),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Task Title",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "Task Description",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Spacer(),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 3),
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
    );
  }
}
