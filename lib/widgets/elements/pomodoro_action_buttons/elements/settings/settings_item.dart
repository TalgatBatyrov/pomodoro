import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final Widget setting;
  final double fontSize;
  final FontWeight fontWeight;
  const SettingsItem({
    Key? key,
    required this.title,
    required this.setting,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      trailing: setting,
    );
  }
}
