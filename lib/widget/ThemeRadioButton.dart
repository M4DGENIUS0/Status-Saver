import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:statussaver/State%20Management/ThemeProvider.dart';
import 'package:statussaver/utilz/assets.dart';

// ignore: must_be_immutable
class ThemeRadioButton extends StatefulWidget {
  String? path;
  IconData? icon;
  String title;
  ThemeMode? value;
  ThemeMode? Groupvalue;

  Color? color;
  bool ImgorIcon;

  ThemeRadioButton({
    Key? key,
    this.path,
    this.icon,
    required this.title,
    this.value,
    this.Groupvalue,
    this.color,
    required this.ImgorIcon,
  }) : super(key: key);

  @override
  State<ThemeRadioButton> createState() => _ThemeRadioButtonState();
}

class _ThemeRadioButtonState extends State<ThemeRadioButton> {
  final groupedvalue = '';
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeProvider>(context, listen: false);

    return RadioListTile<ThemeMode>(
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      groupValue: widget.Groupvalue!,
      value: widget.value!,
      onChanged: themeChanger.setTheme,
      activeColor: assets.green,

     
    );
  }
}
