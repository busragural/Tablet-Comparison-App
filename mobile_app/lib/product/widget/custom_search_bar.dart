// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mobile_app/product/constants/utils/border_radius_constants.dart';

import '../constants/utils/color_constants.dart';

class CustomSearchBar extends StatefulWidget {
  
  final TextEditingController searchController;
  const CustomSearchBar({
    super.key,
    required this.searchController,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  
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
        controller: widget.searchController,
      ),
    );
  }
}
