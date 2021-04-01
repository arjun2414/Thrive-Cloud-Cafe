import 'package:flutter/material.dart';
import 'package:thrive_cloud_cafe/colors.dart';

class FoodRow extends StatelessWidget {
  final String _foodName;
  final int _foodQuantity;

  const FoodRow({String foodName = '', int foodQuantity = 0})
      : _foodName = foodName,
        _foodQuantity = foodQuantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
          decoration: BoxDecoration(
            color: tcc_color.SecondaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(_foodName),
        ),
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
          child: Text(': \t $_foodQuantity'),
        )
      ],
    );
  }
}
