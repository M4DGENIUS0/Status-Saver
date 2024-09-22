import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:statussaver/utilz/assets.dart';
class ExpansionFacebook extends StatelessWidget {
  const ExpansionFacebook({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: '01  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'Open the App and Click Facebook.', style: TextStyle( fontFamily: 'Comfortaa', fontSize: 16,color: Theme.of(context).colorScheme.onSecondary)),
        ])),
      ),
      Gap(10),
      Image.asset(assets.fb1),
      Gap(10),
      Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: '02  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'On top right corner, press the button.', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Comfortaa', fontSize: 16)),
        ])),
      ),
      Gap(10),
      Image.asset(assets.fb2),
      Gap(10),
      Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: '03  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'Choose your reel and click share button.', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Comfortaa', fontSize: 16)),
        ])),
      ),
      Gap(10),
      Image.asset(assets.fb3),
      Gap(10),
      Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: '04  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'Copy Url link.', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Comfortaa', fontSize: 16)),
        ])),
      ),
      Gap(10),
      Image.asset(assets.fb4),
      Gap(10),
      Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: '05  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'Paste the Url in app and click download.', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Comfortaa', fontSize: 16)),
        ])),
      ),
      Gap(10),
      Image.asset(assets.fb5),
            Gap(10),
      Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: '06  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'Download Completed .', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Comfortaa', fontSize: 16)),
        ])),
      ),
      Gap(10),
      Image.asset(assets.fb6),
            Gap(10),
      Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: '07  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'goto Download section and watch your video, Enjoy!.', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Comfortaa', fontSize: 16)),
        ])),
      ),
      Gap(10),
      Image.asset(assets.fb7),


    ],
  );
  }
}