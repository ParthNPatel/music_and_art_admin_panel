import 'package:flutter/material.dart';

import '../configs/theme.dart';

class CustomElevatedTextButton extends StatefulWidget {
  final String message;
  final double? buttonHeight;
  final double? buttonWidth;
  final TextStyle? textStyle;
  final double padding;
  final Color? primaryColor;
  final Color? shadowColor;
  final OutlinedBorder? shape;
  final BorderSide? side;
  final Widget? widget;
  final void Function()? onPressed;
  final Icon? suffixIcon;
  final Function? callback;

  const CustomElevatedTextButton(
      {super.key,
      required this.message,
      required this.onPressed,
      this.textStyle,
      this.padding = 10,
      this.primaryColor,
      this.shadowColor,
      this.buttonHeight,
      this.buttonWidth,
      this.shape,
      this.side,
      this.suffixIcon,
      this.callback,
      this.widget});

  @override
  State<CustomElevatedTextButton> createState() =>
      _CustomElevatedTextButtonState();
}

class _CustomElevatedTextButtonState extends State<CustomElevatedTextButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.buttonHeight,
      width: widget.buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: widget.shape,
          backgroundColor: widget.primaryColor ?? Theme.of(context).focusColor,
          side: widget.side,
          padding: EdgeInsets.all(widget.padding),
          shadowColor: widget.shadowColor,
        ),
        onPressed: widget.onPressed,
        child: Row(
          children: [
            widget,
            Text(
              widget.message,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: widget.textStyle ??
                  const TextStyle(color: CustomColors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
