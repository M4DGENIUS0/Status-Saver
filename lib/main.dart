import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statussaver/Screen/Dashboard/dashboard.dart';
import 'package:statussaver/Screen/WhatsaAppHome.dart';
import 'package:statussaver/State%20Management/Controller/LanguageChangeController.dart';
import 'package:statussaver/State%20Management/Controller/route.dart';
import 'package:statussaver/State%20Management/GetStatusProvider.dart';
import 'package:statussaver/State%20Management/Homeprovider.dart';
import 'package:statussaver/State%20Management/Services/notification_service.dart';
import 'package:statussaver/State%20Management/ThemeProvider.dart';
import 'package:statussaver/State%20Management/direct_chat.dart';
import 'package:statussaver/State%20Management/fetchdownloadstatus.dart';
import 'package:statussaver/State%20Management/notification_provider.dart';
import 'package:statussaver/Theme/Theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationService = NotificationService();
  await notificationService.initialize();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String AppLang = await prefs.getString('Language_Code') ?? '';

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: MyApp(
      Applocale: AppLang,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final String Applocale;
  const MyApp({super.key, required this.Applocale});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => LanguagechangeController()),
        ChangeNotifierProvider(create: (context) => Direct_Chat()),
        ChangeNotifierProvider(create: (context) => StatusFetchProvider()),
        ChangeNotifierProvider(create: (context) => FetchDownloadStatus()),
        ChangeNotifierProvider(create: (context) => StatusNotifyProvider()),
      ],
      child: Consumer<LanguagechangeController>(
        builder: (BuildContext context, value, Widget? child) {
          if (value.applocale == null) {
            Locale locale;
            if (Applocale == 'ur') {
              locale = Locale('ur');
            } else {
              locale = Locale('en');
            }
            value.ChangeLangugae(
                locale, locale.languageCode == 'ur' ? 'Urdu' : 'English');
          }
          return MaterialApp(
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/whatsappscreen':
                  return CustomPageRouteBuilder(child: WhatsaAppHome());
                case '/dashboard':
                  return CustomPageRouteBuilder(child: Dashboard());
                default:
                  return null;
              }
            },
            title: 'Flutter Demo',
            locale: value.applocale ?? Locale('en'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ur'),
            ],
            debugShowCheckedModeBanner: false,
            themeMode: Provider.of<ThemeProvider>(context).thememode,
            theme: Provider.of<ThemeProvider>(context).themeData,
            darkTheme: darkMode,
            home: const Dashboard(),
          );
        },
      ),
    );
  }
}
