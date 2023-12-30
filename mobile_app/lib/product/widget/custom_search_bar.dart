import 'package:flutter/material.dart';
import 'package:mobile_app/product/constants/utils/border_radius_constants.dart';
import '../constants/utils/color_constants.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.LARGE,
        border: Border.all(
          color: BorderColors.SECONDARY_COLOR,
          width: 2,
        ),
      ),
      child: const TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black38,
          ),
          hintText: "Arama yap...",
          hintStyle: TextStyle(color: TextColors.HINT_COLOR),
        ),
      ),
    );
  }
}
