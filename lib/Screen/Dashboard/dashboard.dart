import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    // Schedule the asynchronous permission check and modal display
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
            height: 200,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Request Permission',
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Permission.manageExternalStorage.request();
                    },
                    child: const Text('Confirm'),
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
      length: 2,
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
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        'Meta Media',
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
                                    title: AppLocalizations.of(context)!.videos,
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
              //  showElevation: true,
              onItemSelected: (index) {
                homeProvider.Selectedvalue(index);
              },

              items: [
                FlashyTabBarItem(
                  activeColor: assets.metaColor,
                  inactiveColor: Theme.of(context).colorScheme.secondary,
                  icon: FaIcon(
                    FontAwesomeIcons.home,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(AppLocalizations.of(context)!.status),
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
