import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/settings_provider.dart';
import 'package:todo/screens/widgets/settings_item.dart';
import 'package:todo/screens/widgets/show_language_bottom_sheet.dart';
import 'package:todo/screens/widgets/show_mode_bottom_sheet.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Column(
      children: [
        SettingsItem(
          title: context.tr('language'),
          option: context.locale == Locale("en")
              ? "english".tr()
              : "arabic".tr(),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return ShowLanguageBottomSheet();
              },
            );
          },
        ),
        SizedBox(height: 10.h),
        SettingsItem(
          title: context.tr('mode'),
          option: provider.mode == ThemeMode.light ? "light".tr() : "dark".tr(),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return ShowModeBottomSheet();
              },
            );
          },
        ),
      ],
    );
  }
}
