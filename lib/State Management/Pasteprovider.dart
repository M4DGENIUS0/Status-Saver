import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasteProvider with ChangeNotifier{
  TextEditingController pasteController = TextEditingController();
  TextEditingController pasteControllerFB = TextEditingController();
  TextEditingController get _pasteController => pasteController;
  
  TextEditingController get _pasteControllerFB => pasteControllerFB;
  void pastelink()async{

    final clippaste = await Clipboard.getData(Clipboard.kTextPlain);
        String? clipboardText = clippaste?.text;

    pasteController.text = clipboardText!;
    notifyListeners();
  }
    void pastelinkFB()async{

    final clippaste = await Clipboard.getData(Clipboard.kTextPlain);
        String? clipboardText = clippaste?.text;

    pasteControllerFB.text = clipboardText!;
    notifyListeners();
  }
}