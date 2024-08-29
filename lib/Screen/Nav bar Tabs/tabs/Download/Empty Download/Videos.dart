import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class EmptyBucketVideos extends StatelessWidget {
  const EmptyBucketVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        Icon(Icons.video_collection, color: Colors.grey[600], size: 100,),

        const SizedBox(height: 10,),
        Text(AppLocalizations.of(context)!.no_saved_available,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(height: 6,),

        Text(AppLocalizations.of(context)!.make_sure_to_download, style: TextStyle(fontSize: 14,color: Theme.of(context).colorScheme.secondary),),
        
      ],
    ));
  }
}
