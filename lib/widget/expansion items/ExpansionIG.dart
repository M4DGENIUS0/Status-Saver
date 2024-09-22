import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:statussaver/utilz/assets.dart';


class ExpansionInstagram extends StatelessWidget {
  const ExpansionInstagram({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Gap(50),
      Align(
        alignment: Alignment.topLeft,
        child: Text.rich(
             TextSpan(children: <TextSpan>[
          TextSpan(text: '01  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'Open the App and Click Instagram.', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Comfortaa', fontSize: 16,)),
        ])),
      ),
      Gap(20),
      Image.asset(assets.IG1,),
      Gap(20),
      Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: '02  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'On top right corner, press the button.', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Comfortaa', fontSize: 16,)),
        ])),
      ),
      Gap(10),
      Image.asset(assets.IG2),
      Gap(10),
      Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: '03  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'Choose your reel and click share button.', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Comfortaa', fontSize: 16,)),
        ])),
      ),
      Gap(10),
      Image.asset(assets.IG3),
      Gap(10),
      Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: '04  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'Copy Url link.', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Comfortaa', fontSize: 16,)),
        ])),
      ),
      Gap(10),
      Image.asset(assets.IG4),
      Gap(10),
      Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: '05  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'Paste the Url in app and click download.', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Comfortaa', fontSize: 16,)),
        ])),
      ),
      Gap(10),
      Image.asset(assets.IG5),
            Gap(10),
      Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: '06  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'Download Completed .', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Comfortaa', fontSize: 16,)),
        ])),
      ),
      Gap(10),
      Image.asset(assets.IG6),
            Gap(10),
      Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: '07  ',style: TextStyle(color: assets.metaColor, fontFamily: 'Comfortaa', fontSize: 16, fontWeight: FontWeight.bold)),
          TextSpan(text: 'goto Download section and watch your video, Enjoy!.', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontFamily: 'Comfortaa', fontSize: 16,)),
        ])),
      ),
      Gap(10),
      Image.asset(assets.IG7),


    ],
  );
  }
}
