import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fui_kit/maps/regular_rounded.dart';
import 'package:fui_kit/widgets/icons/icon_widget.dart';

class Glassbox extends StatelessWidget {
  final double height;
  final String herotag;
  final double width;
  final Color g1;
  final Color g2; 
    final Color? strokeColor;
  final String imgPath; // Use a more descriptive name
  final String title;
  final VoidCallback onTap;
   Glassbox(
      {super.key,
      required this.height,
      required this.width,
      required this.g1, required this.g2, this.strokeColor, required this.imgPath, required this.title, required this.onTap, required this.herotag});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        
        padding: EdgeInsets.all(5),
        
        height: height,
        width: width,
        child: Stack(
          children: [
            //Blur effect
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Container(
                height: height,
                width: width,
                padding: EdgeInsets.all(5),
                ),
            ),
            //Gradient Efect
            Container(
              
              padding: EdgeInsets.all(5),
              
              decoration: BoxDecoration(
                
                  border: Border.all(color: strokeColor ?? Colors.white.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(colors: [
                    g1,
                    g2
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            ),
            //Child here
            InkWell(
      onTap: onTap,
      child: Padding( 
        padding: const EdgeInsets.all(8.0), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Row(
              children: [
                Hero(
                  flightShuttleBuilder: (BuildContext flightContext, Animation<double> animation, 
                HeroFlightDirection flightDirection, BuildContext fromHeroContext, BuildContext toHeroContext) {
              return RotationTransition(
                
                turns: animation,
                child: fromHeroContext.widget,
              );
            },
                  tag: herotag, child: Image.asset(imgPath, height: 30, width: 30)), 
                const SizedBox(width: 8.0), 
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Align( 
              alignment: Alignment.bottomRight,
              child: FUI(RegularRounded.ARROW_RIGHT),
            ),
          ],
        ),
      ),
    ),
          ],
        ),
      ),
    );
  }
}
