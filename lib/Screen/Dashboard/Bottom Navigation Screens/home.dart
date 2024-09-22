import 'package:flutter/material.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:statussaver/widget/GlassBox.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  AppLocalizations.of(context)!.explore,
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 25),
                )),
          ),
          SizedBox(
            height: 400,
            width: double.infinity,
            child: GridView.count(
              crossAxisSpacing: 10,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: [
                Glassbox(
                  title: AppLocalizations.of(context)!.whatsapp,
                  imgPath: assets.whatsapp,
                  strokeColor: assets.green,
                  onTap: () {
                    Navigator.pushNamed(context, '/whatsappscreen');
                  },
                  height: 70,
                  width: 40,
                  g1: assets.green.withOpacity(0.2),
                  g2: assets.green.withOpacity(0.1),
                  herotag: 'whatsapp',
                ),
                Glassbox(
                  title: AppLocalizations.of(context)!.instagram,
                  imgPath: assets.Instagram,
                  strokeColor: assets.instgramColor3,
                  onTap: () {
                    Navigator.pushNamed(context, '/instagramScreen');
                  },
                  height: 70,
                  width: 40,
                  g1: assets.instgramColor3.withOpacity(0.2),
                  g2: assets.instgramColor1.withOpacity(0.1),
                  herotag: 'instagram',
                ),
                Glassbox(
                  title: AppLocalizations.of(context)!.facebook,
                  imgPath: assets.Facebook,
                  strokeColor: assets.facebook,
                  onTap: () {
                    Navigator.pushNamed(context, '/facebookscreen');

                  },
                  height: 70,
                  width: 40,
                  g1: assets.facebook.withOpacity(0.2),
                  g2: assets.facebook.withOpacity(0.1),
                  herotag: 'facebook',
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
