import 'package:flutter/material.dart';

class ServingButtons extends StatefulWidget {
  const ServingButtons({
    Key? key,
    this.buttonText,
    this.buttonFont,
    this.buttonWidth,
    this.buttonHeight,
    this.buttonColor,
    this.screenWidth,
    this.screenHeight,
    this.onPressed,
  }) : super(key: key);

  final String? buttonText;
  final TextStyle? buttonFont;

  final double? buttonWidth;
  final double? buttonHeight;
  final Color? buttonColor;
  final double? screenWidth;
  final double? screenHeight;
  final VoidCallback? onPressed;

  @override
  State<ServingButtons> createState() => _ServingButtonsState();
}

class _ServingButtonsState extends State<ServingButtons> {

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed:widget.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.buttonText!,
              style: widget.buttonFont,
            ),
          ],
        ),
        style: TextButton.styleFrom(
            backgroundColor: widget.buttonColor,
            fixedSize: Size(widget.buttonWidth!, widget.buttonHeight!),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Color(0xFFB7B7B7),
                  style: BorderStyle.solid,
                  width: 1),
                borderRadius: BorderRadius.circular(40))));
  }
}