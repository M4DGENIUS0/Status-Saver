import 'package:flutter/material.dart';

class DetailPageBar extends StatelessWidget {
  final VoidCallback? repost;
  final VoidCallback? share;
  final VoidCallback? download;

  const DetailPageBar({super.key,  this.repost,  this.share,  this.download});

  @override
  Widget build(BuildContext context) {
    return  Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: repost,
              child: const Column(
                children: [
                  Icon(
                    Icons.repeat_rounded,
                    color: Colors.white,
                  ),
                  Text(
                    "Repost",
                    style: TextStyle(
                      fontSize: 15,
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: share,
              child: const Column(
                children: [
                  Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  Text(
                    "Share",
                    style: TextStyle(
                      fontSize: 15,
              
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: download,
              child: const Column(
                children: [
                  Icon(
                    Icons.download_rounded,
                    color: Colors.white,
                  ),
                  Text(
                    "Download",
                    style: TextStyle(
                      fontSize: 15,
              
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        );
  }
}