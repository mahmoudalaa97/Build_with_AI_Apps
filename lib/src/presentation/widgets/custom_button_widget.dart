import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final VoidCallback onPressed;
  final String buttonText;
  final Color textColor;
  final double fontSize;
  final Color borderColor;
  final double borderRadius;
  final bool visible;

  const CustomButton({
    Key? key,
    this.height = 50.0,
    required this.onPressed,
    required this.buttonText,
    required this.textColor,
    this.fontSize = 20.0,
    this.borderColor = Colors.transparent,
    this.borderRadius = 10.0,
    this.visible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: MaterialButton(
        height: height,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderColor),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
      ),
    );
  }
}
