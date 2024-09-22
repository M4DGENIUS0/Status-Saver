import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/State%20Management/Homeprovider.dart';
import 'package:statussaver/State%20Management/Pasteprovider.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:statussaver/widget/Tabitem.dart';
import 'package:statussaver/widget/customtoast.dart';

class HomeNavPageIntagram extends StatefulWidget {
  const HomeNavPageIntagram({super.key});

  @override
  State<HomeNavPageIntagram> createState() => _HomeNavPageIntagramState();
}

class _HomeNavPageIntagramState extends State<HomeNavPageIntagram> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PasteProvider>(context, listen: false)
          .pasteController
          .clear();
    });
  }

  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          bottomNavigationBar: FlashyTabBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            iconSize: 25,
            selectedIndex: homeProvider.selectedindex,
            onItemSelected: (index) {
              homeProvider.Selectedvalue(index);
            },
            items: [
              FlashyTabBarItem(
                activeColor: assets.instgramColor2,
                inactiveColor: Theme.of(context).colorScheme.secondary,
                icon: Image.asset(
                  color: Theme.of(context).colorScheme.secondary,
                  assets.Instagram,
                  height: 25,
                  width: 25,
                ),
                title: Text(AppLocalizations.of(context)!.instagram),
              ),
              FlashyTabBarItem(
                activeColor: assets.instgramColor2,
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
                .InstagramBotmNavsTab(), // Fetch the tab items from the assets class
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
                tag: 'instagram',
                child: Image.asset(
                  assets.Instagram,
                  height: 30,
                  width: 30,
                )),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20),
                child: InkWell(
                  onLongPress: () {
                    showCustomToast(
                        context, AppLocalizations.of(context)!.open_Instagram);
                  },
                  onTap: () async {
                    await LaunchApp.openApp(
                      androidPackageName: 'com.instagram.android',
                    );
                  },
                  child: Image.asset(
                    color: Theme.of(context).colorScheme.primary,
                    assets.Instagram,
                    height: 25,
                    width: 25,
                  ),
                ),
              )
            ],
            bottom: homeProvider.selectedindex != 1
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.orange.shade100),
                        child: TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                                color: assets.instgramColor4,
                                borderRadius: BorderRadius.circular(10)),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              TabItem(
                                title:
                                    AppLocalizations.of(context)!.downloadReel,
                              ),
                              TabItem(
                                title:
                                    AppLocalizations.of(context)!.downloadStory,
                              ),
                            ]),
                      ),
                    ))
                : null,
          ),
        ));
  }
}
