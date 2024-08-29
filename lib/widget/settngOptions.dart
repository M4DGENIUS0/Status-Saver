import 'package:flutter/material.dart';

class SettingOption extends StatelessWidget {
  final String title;
  final String description;
  final Widget? data;
  const SettingOption(
      {super.key,
      required this.title,
      required this.description,
      this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
      ),
      titleTextStyle: TextStyle(
          fontSize: 19, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
          subtitle: Text(description),
          subtitleTextStyle: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 11),
          trailing: data,
    );
  }
}
