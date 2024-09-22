import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/State%20Management/Homeprovider.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:statussaver/widget/Tabitem.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkAndRequestPermission();
    });
  }

  Future<void> _checkAndRequestPermission() async {
    final status = await Permission.manageExternalStorage.status;

    if (!status.isGranted) {
      showModalBottomSheet(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop;
                            },
                            child: Icon(Icons.close_rounded,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary))),
                  ),
                  const Gap(20),
                  Text(
                    'Request Permission',
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                  const Gap(30),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () async {
                        await Permission.manageExternalStorage.request();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: assets.metaColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: homeProvider.selectedindex != 2
            ? AppBar(
                title: Row(
                  children: [
                    Image.asset(
                      assets.metamedia,
                      height: 50,
                      width: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        AppLocalizations.of(context)!.meta_media,
                        style: TextStyle(
                            fontFamily: 'LilitaOne', color: assets.metaColor),
                      ),
                    ),
                  ],
                ),
                actions: [
                  InkWell(
                      onTap: () {},
                      child: const Image(
                        image: AssetImage(assets.crown),
                        height: 26,
                        width: 26,
                      )),
                  const SizedBox(
                    width: 8,
                  )
                ],
                bottom: homeProvider.selectedindex != 0
                    ? PreferredSize(
                        preferredSize: const Size.fromHeight(40),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue.shade100),
                            child: TabBar(
                                indicatorSize: TabBarIndicatorSize.tab,
                                dividerColor: Colors.transparent,
                                indicator: BoxDecoration(
                                    color: assets.metaColor,
                                    borderRadius: BorderRadius.circular(10)),
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.black,
                                tabs: [
                                  TabItem(
                                    title: AppLocalizations.of(context)!.photos,
                                  ),
                                  TabItem(
                                    title:
                                        AppLocalizations.of(context)!.whatsapp,
                                  ),
                                  TabItem(
                                    title:
                                        AppLocalizations.of(context)!.instagram,
                                  ),
                                  TabItem(
                                    title:
                                        AppLocalizations.of(context)!.facebook,
                                  ),
                                ]),
                          ),
                        ))
                    : null)
            : null,
        body: Consumer<HomeProvider>(
          builder:
              (BuildContext context, HomeProvider homeProvider, Widget? child) {
            return StreamBuilder<List<Widget>>(
              stream: assets
                  .getHomeTabItems(), // Fetch the tab items from the assets class
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text("Error occurred: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  return snapshot.data!.elementAt(homeProvider
                      .selectedindex); // Access the correct widget based on selected index
                } else {
                  return const Center(child: Text("Unexpected error"));
                }
              },
            );
          },
        ),
        bottomNavigationBar: Consumer<HomeProvider>(
          builder:
              (BuildContext context, HomeProvider homeProvider, Widget? child) {
            return FlashyTabBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              iconSize: 25,
              selectedIndex: homeProvider.selectedindex,
              onItemSelected: (index) {
                homeProvider.Selectedvalue(index);
              },
              items: [
                FlashyTabBarItem(
                  activeColor: assets.metaColor,
                  inactiveColor: Theme.of(context).colorScheme.secondary,
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Image.asset(
                      assets.metamedia,
                      height: 40,
                      width: 40,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  title: Text(AppLocalizations.of(context)!.meta_media),
                ),
                FlashyTabBarItem(
                  activeColor: assets.metaColor,
                  inactiveColor: Theme.of(context).colorScheme.secondary,
                  icon: Icon(
                    Icons.file_download_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(AppLocalizations.of(context)!.download),
                ),
                FlashyTabBarItem(
                  activeColor: assets.metaColor,
                  inactiveColor: Theme.of(context).colorScheme.secondary,
                  icon: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(AppLocalizations.of(context)!.setting),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
