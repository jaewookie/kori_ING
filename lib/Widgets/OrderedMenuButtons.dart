import 'package:flutter/material.dart';

class OrderedMenuButtons extends StatefulWidget {
  const OrderedMenuButtons({
    Key? key,
    this.buttonText,
    this.itemName,
    this.buttonFont,
    this.buttonWidth,
    this.buttonHeight,
    this.buttonColor,
    this.screenWidth,
    this.screenHeight,
    this.onPressed,
  }) : super(key: key);

  final String? buttonText;
  final String? itemName;
  final TextStyle? buttonFont;

  final double? buttonWidth;
  final double? buttonHeight;
  final Color? buttonColor;
  final double? screenWidth;
  final double? screenHeight;
  final VoidCallback? onPressed;

  @override
  State<OrderedMenuButtons> createState() => _OrderedMenuButtonsState();
}

class _OrderedMenuButtonsState extends State<OrderedMenuButtons> {

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed:widget.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text("테이블 번호 : ", style: widget.buttonFont,),
                    Text(
                      widget.buttonText!,
                      style: widget.buttonFont,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("주문 상품 : ", style: widget.buttonFont,),
                    Text(
                      widget.itemName!,
                      style: widget.buttonFont,
                    ),
                  ],
                ),
              ],
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