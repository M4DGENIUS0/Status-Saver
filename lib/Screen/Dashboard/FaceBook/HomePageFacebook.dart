import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/State%20Management/Homeprovider.dart';
import 'package:statussaver/State%20Management/Pasteprovider.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:statussaver/widget/customtoast.dart';

class HomeNavPageFB extends StatefulWidget {
  const HomeNavPageFB({super.key});

  @override
  State<HomeNavPageFB> createState() => _HomeNavPageFBState();
}

class _HomeNavPageFBState extends State<HomeNavPageFB> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PasteProvider>(context, listen: false)
          .pasteControllerFB
          .clear();
    });
  }

  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        bottomNavigationBar: FlashyTabBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          iconSize: 25,
          selectedIndex: homeProvider.selectedindex,
          //  showElevation: true,
          onItemSelected: (index) {
            homeProvider.Selectedvalue(index);
          },

          items: [
            FlashyTabBarItem(
              activeColor: assets.facebook,
              inactiveColor: Theme.of(context).colorScheme.secondary,
              icon: Image.asset(
                color: Theme.of(context).colorScheme.secondary,
                assets.fb,
                height: 20,
                width: 20,
              ),
              title: Text(AppLocalizations.of(context)!.facebook),
            ),
            FlashyTabBarItem(
              activeColor: assets.facebook,
              inactiveColor: Theme.of(context).colorScheme.secondary,
              icon: Icon(
                Icons.file_download_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text(AppLocalizations.of(context)!.download),
            ),
          ],
        ),
        body: StreamBuilder<List<Widget>>(
          stream: assets
              .FBBotmNavsTab(), // Fetch the tab items from the assets class
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error occurred: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              return snapshot.data!.elementAt(homeProvider
                  .selectedindex); // Access the correct widget based on selected index
            } else {
              return const Center(child: Text("Unexpected error"));
            }
          },
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Hero(
              tag: 'facebook',
              child: Image.asset(
                assets.Facebook,
                height: 30,
                width: 30,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20),
              child: InkWell(
                onLongPress: () {
                  showCustomToast(
                      context, AppLocalizations.of(context)!.open_Facebook);
                },
                onTap: () async {
                  await LaunchApp.openApp(
                    androidPackageName: 'com.facebook.katana',
                  );
                },
                child: Image.asset(
                  assets.fb,
                  color: Theme.of(context).colorScheme.primary,
                  height: 25,
                  width: 25,
                ),
              ),
            ),
          ],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ));
  }
}
