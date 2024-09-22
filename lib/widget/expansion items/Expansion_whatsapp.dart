import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:statussaver/utilz/assets.dart';

class ExpansionWhatsapp extends StatelessWidget {
  const ExpansionWhatsapp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: RichText(
        
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: '01  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'Open the Updates tab.', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Comfortaa', fontSize: 16,)),
        ])),
      ),
      Gap(10),
      Image.asset(assets.whatsapp1),
      Gap(10),
      Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: '02  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'Open this app to save statues.', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Comfortaa', fontSize: 16,)),
        ])),
      ),
      Gap(10),
      Image.asset(assets.whatsapp2),
    ],
  );
  }
}
