import 'package:flutter/material.dart';
import 'package:statussaver/Screen/Dashboard/Whatsapp/WhatsaAppHome.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 330,
            ),
            const Icon(
              Icons.downloading_rounded,
              size: 85,
              color: assets.green,
            ),
            Text(
              AppLocalizations.of(context)!.onboardng,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 220,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: assets.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WhatsaAppHome(),
                        ));
                  },
                  child: Text(
                    AppLocalizations.of(context)!.go,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {},
                    child: Text(
                      AppLocalizations.of(context)!.privacy_policy_detail,
                      style: const TextStyle(color: assets.green, fontSize: 12),
                    )),
                const Text(" | "),
                InkWell(
                    onTap: () {},
                    child: Text(
                      AppLocalizations.of(context)!.privacy_policy,
                      style: const TextStyle(color: assets.green, fontSize: 12),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
