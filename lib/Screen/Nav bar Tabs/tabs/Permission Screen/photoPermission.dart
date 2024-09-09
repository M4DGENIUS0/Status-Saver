import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatusPicturePermission extends StatefulWidget {
  const StatusPicturePermission({super.key});

  @override
  State<StatusPicturePermission> createState() =>
      _StatusPicturePermissionState();
}

class _StatusPicturePermissionState extends State<StatusPicturePermission> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.photo_library,
          color: Colors.grey[600],
          size: 100,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          AppLocalizations.of(context)!.no_image_available,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          AppLocalizations.of(context)!.allow_permission_to_access_pictures,
          style: TextStyle(
              fontSize: 14, color: Theme.of(context).colorScheme.secondary),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 220,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: assets.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    size: 17,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    AppLocalizations.of(context)!.allow_permission,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              )),
        )
      ],
    ));
  }
}
