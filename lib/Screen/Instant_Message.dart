import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:fui_kit/maps/regular_rounded.dart';
import 'package:fui_kit/widgets/icons/icon_widget.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/State%20Management/direct_chat.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:statussaver/widget/customradiobutton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class InstantMessage extends StatefulWidget {
  const InstantMessage({super.key});

  @override
  State<InstantMessage> createState() => _InstantMessageState();
}

class _InstantMessageState extends State<InstantMessage> {
  @override
  Widget build(BuildContext context) {
    final _focusNode = FocusNode();
    var message = '';

    final realphonenumber = Provider.of<Direct_Chat>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.direct_chat,
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomRadioButton(
                  assetPath: assets.whatsapp,
                  value: '1',
                ),
                CustomRadioButton(
                  assetPath: assets.whatsappBusiness,
                  value: '2',
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 320,
              height: 80,
              child: IntlPhoneField(
                
                onChanged: (value) {
                      realphonenumber.updatePhoneNumber(value.completeNumber);

                 

                },
                cursorColor: Theme.of(context).colorScheme.onSecondary,
                disableLengthCheck: true,
                dropdownIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),

                dropdownTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 17),
                dropdownIconPosition: IconPosition.leading,
                pickerDialogStyle: PickerDialogStyle(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  countryCodeStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary),
                  countryNameStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary),
                  listTileDivider: Divider(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  searchFieldCursorColor:
                      Theme.of(context).colorScheme.onSecondary,
                  searchFieldInputDecoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: assets.green),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: assets.green),
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                    suffixIcon: const Icon(Icons.search),
                    suffixIconColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                keyboardType: TextInputType.phone,
                initialCountryCode: 'PK',
                invalidNumberMessage:
                    AppLocalizations.of(context)!.number_error,
                showCountryFlag: false,
                style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context).colorScheme.onSecondary),
                decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: assets.green,
                        ),
                        borderRadius: BorderRadius.circular(40)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    hintText: AppLocalizations.of(context)!.enter_number),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                _focusNode.unfocus();
              },
              child: Container(
                width: 320,
                height: 300,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    onChanged: (value) {
                      message = value.toString();
                      print('message box value: $message');
                    },
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                    onSubmitted: (_) {},
                    focusNode: _focusNode,
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    decoration: InputDecoration.collapsed(
                        hintText: AppLocalizations.of(context)!
                            .enter_your_message_here,
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: assets.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  onPressed: () async {
                    var url = 'https://wa.me/${realphonenumber.formattedNumber}?text=$message';
                    await canLaunchUrl(Uri.parse(url))
                        ? await launchUrl(Uri.parse(url))
                        : print('Error');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FUI(
                        RegularRounded.PAPER_PLANE,
                        height: 17,
                        width: 17,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppLocalizations.of(context)!.send,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: assets.green),
                          borderRadius: BorderRadius.circular(40))),
                  onPressed: () async {
                    try{
                      var url = 'https://wa.me/${realphonenumber.formattedNumber}?text=$message';
                    await FlutterNativeApi.shareText('Share now! $url');
                    }catch(e){
                      print("Error: $e");
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FUI(
                        RegularRounded.SHARE,
                        height: 17,
                        width: 17,
                        color: assets.green,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppLocalizations.of(context)!.share_link,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: assets.green),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
