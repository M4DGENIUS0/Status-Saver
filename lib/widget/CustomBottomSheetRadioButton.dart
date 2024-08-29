import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/radio_list_tile/gf_radio_list_tile.dart';
import 'package:getwidget/types/gf_radio_type.dart';
import 'package:provider/provider.dart';

import 'package:statussaver/State%20Management/Homeprovider.dart';
import 'package:statussaver/utilz/assets.dart';

class CustomRadioButtonBottomSheet extends StatefulWidget {
  String? path;
  IconData? icon;
  String title;
  String value;
  Color? color;
  bool ImgorIcon;

  CustomRadioButtonBottomSheet({
    Key? key,
    this.path,
    this.icon,
    required this.title,
    required this.value,
    this.color,
    required this.ImgorIcon,
  }) : super(key: key);

  @override
  State<CustomRadioButtonBottomSheet> createState() =>
      _CustomRadioButtonBottomSheetState();
}

class _CustomRadioButtonBottomSheetState
    extends State<CustomRadioButtonBottomSheet> {
  final groupedvalue = '';
  @override
  Widget build(BuildContext context) {
    final getvalue = Provider.of<HomeProvider>(context);
    return GFRadioListTile(
      title: Text(
        widget.title,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.normal, color: widget.color),
      ),
      avatar: widget.ImgorIcon
          ? GFAvatar(
              backgroundImage: AssetImage(widget.path!),
              backgroundColor: Colors.transparent,
            )
          : GFAvatar(
              child: Icon(
                widget.icon,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
      groupValue: getvalue.index,
      value: widget.value,
      onChanged: (value) {
        getvalue.BottomSheetradio(value!);
      },
      activeBorderColor: assets.green,
      size: 25,
      type: GFRadioType.basic,
    );
  }
}
