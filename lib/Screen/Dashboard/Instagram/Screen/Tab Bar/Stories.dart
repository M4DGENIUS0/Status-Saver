import 'package:flutter/material.dart';

class Stories extends StatefulWidget {
  const Stories({super.key});

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction, size: 55,color: Theme.of(context).colorScheme.primary,),
          Text('This Page is under maintaince!', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20),),
        ],
      ),),
    );
  }
}