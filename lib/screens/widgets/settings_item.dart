import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/shared/styles/app_colors.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String option;
  final VoidCallback onTap;

  const SettingsItem({
    super.key,
    required this.title,
    required this.option,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          SizedBox(height: 10.h),
          InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              margin: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : AppColors.darkPrimaryColor,
              ),
              child: Text(option),
            ),
          ),
        ],
      ),
    );
  }
}
