import 'package:flutter/material.dart';
import 'package:statussaver/widget/expansion%20items/ExpansionFB.dart';
import 'package:statussaver/widget/expansion%20items/ExpansionIG.dart';
import 'package:statussaver/widget/expansion%20items/Expansion_whatsapp.dart';
import 'package:statussaver/widget/expansion%20items/Expansion/Item.dart';

class Expansionwidget extends StatefulWidget {
  const Expansionwidget({super.key});

  @override
  State<Expansionwidget> createState() => _ExpansionwidgetState();
}

class _ExpansionwidgetState extends State<Expansionwidget> {
  @override
  List<Items> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      Items(
        title: 'Whatsapp',
        child: ExpansionWhatsapp(),
      ),
      Items(
        title: 'Instagram',
        child: ExpansionInstagram(),
      ),
      Items(
        title: 'Facebook',
        child: ExpansionFacebook(),
      ),
    ];
  }

  Widget build(BuildContext context) {
    return ExpansionPanelList.radio(
      dividerColor: Theme.of(context).colorScheme.onSecondary,
      expandIconColor: Theme.of(context).colorScheme.onSecondary,
      animationDuration: Duration(milliseconds: 500),
      materialGapSize: 10,
      children: items
          .map((items) => ExpansionPanelRadio(
              backgroundColor: Theme.of(context).colorScheme.surface,
              canTapOnHeader: true,
              value: items.title!,
              headerBuilder: (context, isExpanded) => ListTile(
                    title: Text(items.title!),
                    titleTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 16),
                  ),
              body: ListTile(
                title: items.child,
              )))
          .toList(),
    );
  }
}
