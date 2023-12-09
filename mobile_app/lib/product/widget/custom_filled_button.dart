import 'package:flutter/material.dart';
import 'package:mobile_app/product/constants/utils/padding_constants.dart';
import '../constants/utils/border_radius_constants.dart';

class CustomFilledButton extends StatelessWidget {
  final double? width;
  final Color backgroundColor;
  final Color? borderColor;
  final String text;
  final TextStyle textStyle;
  final void Function() onTap;

  const CustomFilledButton({
    super.key,
    this.width,
    this.borderColor,
    required this.backgroundColor,
    required this.text,
    required this.textStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorderRadius.LARGE,
      child: Material(
        child: InkWell(
          overlayColor: const MaterialStatePropertyAll(Colors.white10),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: AppBorderRadius.LARGE,
              border: Border.all(
                color: borderColor ?? backgroundColor,
              )
            ),
            child: Padding(
              padding: AppPaddings.SMALL_V + AppPaddings.LARGE_H,
              child: Text(
                text,
                style: textStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
