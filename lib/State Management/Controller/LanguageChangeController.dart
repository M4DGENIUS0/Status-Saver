import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagechangeController with ChangeNotifier {
  Locale? _applocale;
  Locale? get applocale => _applocale;
  String? _langname = "English";
  String? get langname => _langname;

  void ChangeLangugae(Locale locale, String language) async {
    _applocale = locale;
    _langname = language;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    await prefs.setString("Language_Code", locale.languageCode);
    await prefs.setString('Language_Name', language);

    notifyListeners();
  }
}
