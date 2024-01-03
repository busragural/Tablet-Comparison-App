import 'package:flutter/material.dart';

import '../../constants/utils/color_constants.dart';

class PriceTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController priceController;
  const PriceTextField({
    super.key,
    required this.hintText, required this.priceController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: priceController,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: TextColors.HINT_COLOR),
        suffixText: "TL",
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: BorderColors.TEXTFIELD_COLOR)
        )
      ),
    );
  }
}
