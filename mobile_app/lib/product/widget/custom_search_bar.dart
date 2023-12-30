import 'package:flutter/material.dart';
import 'package:mobile_app/product/constants/utils/border_radius_constants.dart';
import '../constants/utils/color_constants.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  
  TextEditingController searchController = TextEditingController();

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
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black38,
          ),
          hintText: "Arama yap...",
          hintStyle: TextStyle(color: TextColors.HINT_COLOR),
        ),
        controller: searchController,
      ),
    );
  }
}
