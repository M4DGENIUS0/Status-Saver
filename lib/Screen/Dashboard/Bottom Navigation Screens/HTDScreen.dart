import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:statussaver/widget/expansion%20items/Expansion/ExpansionWidget.dart';
class HTDScreen extends StatelessWidget {
  const HTDScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),),
      body: SingleChildScrollView(
        child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Gap(10),
              Text('How to do', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 25, fontFamily: 'Comfortaa')),
              Gap(20),
              Expansionwidget(),
              Gap(20),
              Center(
                child: SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: assets.metaColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      onPressed: (){Navigator.pop(context);}, child: Text('Got it', style: TextStyle(color: Theme.of(context).colorScheme.surface)))),
              ),
              ]
              
        ),
      ),
    );
  }
}
