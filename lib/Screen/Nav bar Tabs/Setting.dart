import 'package:flutter/material.dart';
import 'package:load_switch/load_switch.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/State%20Management/Controller/LanguageChangeController.dart';
import 'package:statussaver/State%20Management/ThemeProvider.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:statussaver/widget/ThemeRadioButton.dart';
import 'package:statussaver/widget/settngOptions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

enum language { English, Urdu }

class _SettingState extends State<Setting> {
  bool value = false;

  Future<bool> _getFuture() async {
    await Future.delayed(const Duration(seconds: 2));
    return !value;
  }

  @override
  Widget build(BuildContext context) {
    final systemtheme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          AppLocalizations.of(context)!.setting,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: SizedBox(
              width: 320,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, left: 12),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!.advance,
                        style:
                            const TextStyle(fontSize: 14, color: assets.green),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(10)),
                    width: 320,
                    height: 440,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SettingOption(
                          title:
                              AppLocalizations.of(context)!.download_location,
                          description: AppLocalizations.of(context)!
                              .download_location_detail,
                        ),
                        SettingOption(
                            title: AppLocalizations.of(context)!.notification,
                            description: AppLocalizations.of(context)!
                                .notification_detail,
                            data: LoadSwitch(
                              height: 25,
                              width: 50,
                              value: value,
                              future: _getFuture,
                              onChange: (v) {
                                value = v;
                              },
                              onTap: (bool) {
                                print(value);
                              },
                            )),
                        SettingOption(
                            title: AppLocalizations.of(context)!.auto_save,
                            description:
                                AppLocalizations.of(context)!.auto_save_detail,
                            data: LoadSwitch(
                              height: 25,
                              width: 50,
                              value: value,
                              future: _getFuture,
                              onChange: (v) {
                                value = v;
                              },
                              onTap: (bool) {
                                print(value);
                              },
                            )),
                        SettingOption(
                          title: AppLocalizations.of(context)!.language,
                          description:
                              AppLocalizations.of(context)!.language_detail,
                          data: Consumer<LanguagechangeController>(
                            builder: (BuildContext context,
                                LanguagechangeController value, Widget? child) {
                              return PopupMenuButton(
                                color: Theme.of(context).colorScheme.onSurface,
                                child: Text(
                                  value.langname!,
                                  style: const TextStyle(
                                      color: assets.green, fontSize: 14),
                                ),
                                onSelected: (language item) {
                                  if (language.English.name == item.name) {
                                    value.ChangeLangugae(
                                        const Locale('en'), "English");
                                  } else {
                                    value.ChangeLangugae(
                                        const Locale('ur'), "Urdu");
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<language>>[
                                  PopupMenuItem(
                                      value: language.English,
                                      child: Text(
                                        'English',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary),
                                      )),
                                  PopupMenuItem(
                                      value: language.Urdu,
                                      child: Text('Urdu',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary)))
                                ],
                              );
                            },
                          ),
                        ),
                        SettingOption(
                            title: AppLocalizations.of(context)!.theme,
                            description:
                                AppLocalizations.of(context)!.theme_detail,
                            data: TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface,
                                  context: context,
                                  builder: (BuildContext context) {
                                    final themeProvider =
                                        Provider.of<ThemeProvider>(context,
                                            listen: false);

                                    return SizedBox(
                                      height: 320,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: ThemeRadioButton(
                                              ImgorIcon: false,
                                              icon: Icons.settings,
                                              title:
                                                  AppLocalizations.of(context)!
                                                      .system_default,
                                              path: assets.whatsapp,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              value: ThemeMode.system,
                                              Groupvalue:
                                                  themeProvider.thememode,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: ThemeRadioButton(
                                              ImgorIcon: false,
                                              icon: Icons.light_mode_outlined,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              title:
                                                  AppLocalizations.of(context)!
                                                      .light,
                                              path: assets.whatsappBusiness,
                                              value: ThemeMode.light,
                                              Groupvalue:
                                                  themeProvider.thememode,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: ThemeRadioButton(
                                              ImgorIcon: false,
                                              icon: Icons.dark_mode_outlined,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              title:
                                                  AppLocalizations.of(context)!
                                                      .dark,
                                              value: ThemeMode.dark,
                                              Groupvalue:
                                                  themeProvider.thememode,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                systemtheme.systemTheme,
                                style: const TextStyle(color: assets.green),
                              ),
                            )),
                        SettingOption(
                          title: AppLocalizations.of(context)!.how_to_use,
                          description:
                              AppLocalizations.of(context)!.how_to_use_detail,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!.general,
                        style:
                            const TextStyle(fontSize: 14, color: assets.green),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(10)),
                    width: 320,
                    height: 300,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SettingOption(
                          title: AppLocalizations.of(context)!.rate_app,
                          description:
                              AppLocalizations.of(context)!.rate_app_detail,
                        ),
                        SettingOption(
                          title: AppLocalizations.of(context)!.share_with_other,
                          description: AppLocalizations.of(context)!
                              .share_with_other_detail,
                        ),
                        SettingOption(
                          title: AppLocalizations.of(context)!.privacy_policy,
                          description: AppLocalizations.of(context)!
                              .privacy_policy_detail,
                        ),
                        SettingOption(
                          title: AppLocalizations.of(context)!.about,
                          description: '0.0.1',
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
