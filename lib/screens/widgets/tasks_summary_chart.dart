import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TasksSummaryChart extends StatelessWidget {
  final int totalTasksCount;
  final int completedTasksCount;

  const TasksSummaryChart({
    super.key,
    required this.totalTasksCount,
    required this.completedTasksCount,
  });

  @override
  Widget build(BuildContext context) {
    final pendingTasksCount = totalTasksCount - completedTasksCount;

    return SizedBox(
      height: 150.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              centerSpaceRadius: 45.r,
              sectionsSpace: 4,
              sections: [
                if (completedTasksCount > 0)
                  PieChartSectionData(
                    value: completedTasksCount.toDouble(),
                    color: Colors.green,
                    title: '$completedTasksCount',
                    radius: 25.r,
                    titleStyle: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                if (pendingTasksCount > 0)
                  PieChartSectionData(
                    value: pendingTasksCount.toDouble(),
                    color: Colors.red,
                    title: '$pendingTasksCount',
                    radius: 25.r,
                    titleStyle: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$totalTasksCount',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface,
                ),
              ),
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Theme
                      .of(context)
                      .hintColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12.w,
                      height: 12.h,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onSurface,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Container(
                      width: 12.w,
                      height: 12.h,
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Pending",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
