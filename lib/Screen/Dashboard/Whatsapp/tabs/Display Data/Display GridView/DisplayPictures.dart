import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/Screen/Dashboard/Whatsapp/tabs/Display%20Data/Detail%20Page/PictureDetail.dart';
import 'package:statussaver/State%20Management/GetStatusProvider.dart';
import 'package:statussaver/utilz/assets.dart';

class Displaypictures extends StatelessWidget {
  const Displaypictures({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFetch = false;
    return Consumer<StatusFetchProvider>(
      builder: (BuildContext context, value, Widget? child) {
        if (isFetch == false) {
          value.fetchStatus('.jpg');
          Future.delayed(const Duration(microseconds: 1), () {
            isFetch = true;
          });
        }
        return value.WhatsappAvailability == false
            ? const Center(
                child: Text("WhatsApp Not Available"),
              )
            : value.getPictures.isEmpty
                ? const Center(
                    child: Text('No Pictures for Today Come Tomorrow'),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: RefreshIndicator(
                      triggerMode: RefreshIndicatorTriggerMode.onEdge,
                      color: assets.green,
                      onRefresh: () async {
                        Future.delayed(const Duration(seconds: 5));
                        value.fetchStatus('.jpg');
                      },
                      child: GridView(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8),
                          children:
                              List.generate(value.getPictures.length, (index) {
                            final data = value.getPictures[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: const Duration(
                                        milliseconds:
                                            200), // Set slow transition duration
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: DetailPhoto(imgPath: data.path),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'picture $data',
                                child: Stack(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(File(data.path)))),
                                  ),
                                  Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: Icon(
                                          Icons.file_download_off_rounded,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface))
                                ]),
                              ),
                            );
                          })),
                    ),
                  );
      },
    );
  }
}
