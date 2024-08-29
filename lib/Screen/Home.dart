import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fui_kit/fui_kit.dart';
import 'package:fui_kit/widgets/icons/icon_widget.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:statussaver/Screen/Instant_Message.dart';
import 'package:statussaver/widget/Tabitem.dart';
import 'package:statussaver/State%20Management/Homeprovider.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:statussaver/widget/CustomBottomSheetRadioButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const platform = MethodChannel('com.example/openwhatsapp');

  Future<void> _openWhatsApp() async {
    try {
      await platform.invokeMethod('openWhatsApp');
    } on PlatformException catch (e) {
      print("Failed to open WhatsApp: '${e.message}'.");
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
                title: Text(
                  AppLocalizations.of(context)!.onboardng,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
                actions: [
                  GestureDetector(
                    onTap: () async {
                      await Future.delayed(const Duration(milliseconds: 100));
                      // notificationSheet;
                      showModalBottomSheet(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      assets.notification,
                                      height: 70,
                                      width: 70,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.bellnoti,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    
                                    Text(
                                      AppLocalizations.of(context)!
                                          .bellnotidetail,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          height: 50,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                          color: assets.green),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40))),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .bellno,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: assets.green),
                                              )),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          height: 50,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: assets.green,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40))),
                                              onPressed: () {
                                              },
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .bellyes,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: badges.Badge(
                      child: Icon(
                        Icons.notifications_none_rounded,
                        size: 26,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      position: badges.BadgePosition.topEnd(),
                      showBadge: true,
                      ignorePointer: false,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: _openWhatsApp,
                    child: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      size: 26,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  IconButton(
                    icon: FUI(
                        height: 23,
                        color: Theme.of(context).colorScheme.primary,
                        RegularRounded.APPS_ADD),
                    onPressed: () async {
                      await Future.delayed(const Duration(milliseconds: 100));
                      showModalBottomSheet(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 400,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.choose_app,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  CustomRadioButtonBottomSheet(
                                    ImgorIcon: true,
                                    title:
                                        AppLocalizations.of(context)!.whatsapp,
                                    path: assets.whatsapp,
                                    value: 'Whatsapp',
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  CustomRadioButtonBottomSheet(
                                    ImgorIcon: true,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    title: AppLocalizations.of(context)!
                                        .whatsapp_business,
                                    path: assets.whatsappBusiness,
                                    value: 'WhatsappBusiness',
                                  ),
                                  CustomRadioButtonBottomSheet(
                                    ImgorIcon: true,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    title: AppLocalizations.of(context)!
                                        .gb_whatsapp,
                                    path: assets.whatsappGB,
                                    value: 'GB Whatsapp',
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 50,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: assets.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(40))),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Home(),
                                              ));
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.confirm,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                 
                  IconButton(
                    icon: FUI(
                      RegularRounded.PAPER_PLANE,
                      height: 23,
                      color: Theme.of(context).colorScheme.primary,
                      // width: 23,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InstantMessage(),
                          ));
                    },
                  ),
                  
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
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green.shade100),
                        child: TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                                color: assets.green,
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
                    )),
              )
            : null,
        body: assets.tabItems.elementAt(homeProvider.selectedindex),
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
              activeColor: assets.green,
              inactiveColor: Theme.of(context).colorScheme.secondary,
              icon: FaIcon(
                FontAwesomeIcons.whatsapp,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text(AppLocalizations.of(context)!.status),
            ),
            FlashyTabBarItem(
              activeColor: assets.green,
              inactiveColor: Theme.of(context).colorScheme.secondary,
              icon: Icon(
                Icons.file_download_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text(AppLocalizations.of(context)!.download),
            ),
            FlashyTabBarItem(
              activeColor: assets.green,
              inactiveColor: Theme.of(context).colorScheme.secondary,
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text(AppLocalizations.of(context)!.setting),
            ),
          ],
        ),
      ),
    );
  }
}
