import 'package:flutter/material.dart';

import '../../../screens/home/viewmodel/home_viewmodel.dart';
import '../../constants/utils/color_constants.dart';

class CustomCheckbox extends StatefulWidget {
  final HomeViewModel viewModel;
  final String filterType;
  final String choice;
  const CustomCheckbox({
    super.key,
    required this.choice,
    required this.filterType,
    required this.viewModel,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: Checkbox(
            value: widget
                    .viewModel.choiceFilters[widget.filterType.toLowerCase()]![
                widget.choice.toLowerCase().replaceAll(".", "_")],
            shape: const CircleBorder(),
            activeColor: ButtonColors.CHECKBOX_COLOR,
            onChanged: (bool? value) {
              setState(() {
                widget.viewModel.changeCheckboxFilter(
                  widget.filterType,
                  widget.choice,
                  value!,
                );
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
