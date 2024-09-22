
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fui_kit/maps/regular_rounded.dart';
import 'package:fui_kit/widgets/icons/icon_widget.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/State%20Management/Pasteprovider.dart';
import 'package:statussaver/State%20Management/Services/Instagram%20service/flutter_insta.dart';
import 'package:statussaver/State%20Management/Services/Instagram%20service/insta_provider.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:statussaver/widget/customtoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class InstagramScreen extends StatefulWidget {
  const InstagramScreen({super.key});

  @override
  State<InstagramScreen> createState() => _InstagramScreenState();
}

class _InstagramScreenState extends State<InstagramScreen> {
  // Download reel video on button click
  void download() async {
    var pasteProvider = Provider.of<PasteProvider>(context, listen: false);
    var instaProvider = Provider.of<InstaProvider>(context, listen: false);
    var instaDownloadProvider =
        Provider.of<FlutterInsta>(context, listen: false);

    try {
      // Get the video URL
      var myVideoUrl = await instaDownloadProvider
          .downloadReels(pasteProvider.pasteController.text);
        showCustomToast(context, AppLocalizations.of(context)!.download_Started);

      if (myVideoUrl == null || myVideoUrl.isEmpty) {
        instaProvider.downloaded(false);
        print("Invalid video URL");
        showCustomToast(context, 'Invalid video URL');
        return; // Return early to avoid further execution
      }
      
      // Start progress indicator
      instaProvider.downloaded(true);
    } catch (e) {
      showCustomToast(context, "An error occurred while downloading the video.");
      // instaProvider.downloaded(false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final pasteprovider = Provider.of<PasteProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(AppLocalizations.of(context)!.download_Instagram_Reels_Videos,
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Comfortaa',
                      color: Theme.of(context).colorScheme.onSecondary)),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.enter_IG_URL,
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    const Gap(5),
                    InkWell(
                        onLongPress: () {},
                        onTap: () {},
                        child: FUI(
                          RegularRounded.INFO,
                          height: 15,
                          width: 15,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ))
                  ],
                ),
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                height: 70,
                child: TextField(
                  readOnly: false,
                  controller: pasteprovider.pasteController,
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).colorScheme.onSecondary),
                  cursorColor: assets.instgramColor3,
                  enableSuggestions: false,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                      suffix: InkWell(
                        child: Icon(Icons.highlight_remove_rounded),
                        onTap: () {
                          pasteprovider.pasteController.clear();
                        },
                      ),
                      suffixIconColor:
                          Theme.of(context).colorScheme.onSecondary,
                      hintText: AppLocalizations.of(context)!.paste_link_here,
                      hintStyle: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).colorScheme.onSurface),
                      //  fillColor: Theme.of(context).colorScheme.
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: assets.instgramColor2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSurface,
                              width: 4))),
                ),
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<InstaProvider>(
                  builder: (BuildContext context, InstaProvider value,
                      Widget? child) {
                    return ElevatedButton(
                      onPressed: () async {
                         var connectivityResult =
                            await Connectivity().checkConnectivity();
                        if (connectivityResult == ConnectivityResult.none) {
                          showCustomToast(context, AppLocalizations.of(context)!.internet_error);
                          return;
                        } else{
                        value.downloaded(true);
                        print(pasteprovider.pasteController.text.toString());
                        download();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: assets.instgramColor3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: value.downloading
                          ? SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Theme.of(context).colorScheme.surface))
                          : Text(
                              AppLocalizations.of(context)!.download,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.surface),
                            ),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    pasteprovider.pastelink();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: assets.instgramColor3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    AppLocalizations.of(context)!.pasteIG,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.surface),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
