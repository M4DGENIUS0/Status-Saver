import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/State%20Management/Homeprovider.dart';
import 'package:statussaver/utilz/assets.dart';

class CustomRadioButton extends StatelessWidget {
  final String value;
  final String assetPath;
  final double elevation;

  CustomRadioButton({
    required this.value,
    required this.assetPath,
    this.elevation = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    final radioButtonProvider = Provider.of<HomeProvider>(context);
    bool isSelected = radioButtonProvider.selectedValue == value;

    return SizedBox(
      height: 50,
      width: 150,
      child: ElevatedButton(
        onPressed: () {
          radioButtonProvider.selectValue(value);
        },
        style: ElevatedButton.styleFrom(
          elevation: isSelected ? elevation : 0.0, backgroundColor: isSelected ? assets.green : Theme.of(context).colorScheme.surface,
          
          shape: RoundedRectangleBorder(
            side: BorderSide(color: isSelected ? Theme.of(context).colorScheme.surface : assets.green),
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
