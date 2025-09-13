import 'package:flutter/material.dart';

import '../util/constants.dart';

class CancelButtonWidget extends StatelessWidget {
   final String text;
   final Color backgroundColor;
   final TextStyle? textStyle;
   final double width;
   final double height;
   final double borderRadius;
  const CancelButtonWidget({
    super.key,
    this.text = 'Cancel',
    this.backgroundColor = const Color(0xFF1E1E1E),
    this.textStyle,
    this.width = 250,
    this.height = 40,
    this.borderRadius = kBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextStyle = textStyle ??
        Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600);

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Center(
            child: Text(
              text,
              style: effectiveTextStyle,
              semanticsLabel: text,
            ),
          ),
        ),
      ),
    );
  }
}