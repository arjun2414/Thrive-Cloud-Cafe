import 'package:flutter/material.dart';

class CustomSuffixIcon extends StatelessWidget {

  const CustomSuffixIcon({Key key, @required this.chosenIcon}) : super(key : key);

  final IconData chosenIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0), // Use proportionate screen width
      child: InkWell(
        child: Icon(chosenIcon, size: 25,),
      ),
    );
  }
}