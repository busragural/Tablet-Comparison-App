import 'package:flutter/material.dart';

import '../../constants/utils/color_constants.dart';

class CustomCheckbox extends StatefulWidget {
  final String choice;
  const CustomCheckbox({
    super.key,
    required this.choice,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: Checkbox(
            value: isChecked,
            shape: const CircleBorder(),
            activeColor: ButtonColors.CHECKBOX_COLOR,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
        ),
        const SizedBox(width: 10),
        Text(
            widget.choice,
            style: const TextStyle(
              color: TextColors.PRIMARY_COLOR,
              fontSize: 16,
            ),
          ),
      ],
    );
  }
}
