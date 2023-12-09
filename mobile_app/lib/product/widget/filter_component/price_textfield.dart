import 'package:flutter/material.dart';

import '../../constants/utils/color_constants.dart';

class PriceTextField extends StatelessWidget {
  final String hinText;
  const PriceTextField({
    super.key,
    required this.hinText,
  });

  @override
  Widget build(BuildContext context) {
    return const TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "En az",
        hintStyle: TextStyle(color: TextColors.HINT_COLOR),
        suffixText: "TL",
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: BorderColors.TEXTFIELD_COLOR)
        )
      ),
    );
  }
}
