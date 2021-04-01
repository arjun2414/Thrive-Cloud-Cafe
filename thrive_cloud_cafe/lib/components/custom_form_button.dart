import 'package:flutter/material.dart';
import 'package:thrive_cloud_cafe/colors.dart';

class CustomFormButton extends StatelessWidget {

  const CustomFormButton({key, this.onPress, this.label }) : super(key: key);

  final Function onPress;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: (55/812) * MediaQuery.of(context).size.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: tcc_color.SecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
        ),
        child: Text(label),
        onPressed: onPress,
      ),
    );
  }
}
