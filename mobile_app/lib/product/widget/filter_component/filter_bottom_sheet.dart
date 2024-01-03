import 'package:flutter/material.dart';
import 'package:mobile_app/core/base/state/base_state.dart';
import 'package:mobile_app/product/constants/utils/padding_constants.dart';
import 'package:mobile_app/product/widget/custom_filled_button.dart';
import 'package:mobile_app/product/widget/column_divider.dart';
import 'package:mobile_app/product/widget/filter_component/filter_price.dart';
import 'package:mobile_app/screens/home/viewmodel/home_viewmodel.dart';
import '../../constants/utils/color_constants.dart';
import 'filter_multiple_checkbox.dart';

class FilterBottomSheet extends BaseStatelessWidget {
  final HomeViewModel viewModel;
  final TextEditingController leastPriceController;
  final TextEditingController mostPriceController;
  const FilterBottomSheet({required this.leastPriceController, required this.mostPriceController,
      required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dynamicHeightDevice(context, 0.7),
      decoration: const BoxDecoration(
        color: SurfaceColors.PRIMARY_COLOR,
        boxShadow: [
          BoxShadow(
              color: ShadowColors.PRIMARY_COLOR,
              spreadRadius: 0,
              blurStyle: BlurStyle.solid,
              offset: Offset(0, -10)),
        ],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: AppPaddings.LARGE_V + AppPaddings.MEDIUM_H,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FilterPrice(leastPriceController, mostPriceController),
                    const ColumnDivider(),
                    FilterMultipleCheckbox(
                      viewModel: viewModel,
                      filterType: "Marka",
                      choices: const [
                        "Apple",
                        "Samsung",
                        "Huawei",
                        "Xiomi",
                        "Lenovo",
                        "Casper",
                      ],
                    ),
                    const ColumnDivider(),
                    FilterMultipleCheckbox(
                      viewModel: viewModel,
                      filterType: "Boyut",
                      choices: const [
                        "10.9 inç",
                        "11 inç",
                        "12.9 inç",
                        "8 inç",
                        "11.7 inç",
                      ],
                    ),
                    const ColumnDivider(),
                    FilterMultipleCheckbox(
                      viewModel: viewModel,
                      filterType: "Site",
                      choices: const [
                        "Vatan",
                        "Mediamarkt",
                        "Teknosa",
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: CustomFilledButton(
                backgroundColor: ButtonColors.PRIMARY_COLOR,
                text: "Filtrele",
                textStyle: const TextStyle(
                  color: TextColors.BUTTON_TEXT_COLOR,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  viewModel.filterTablets(
                      leastPriceController, mostPriceController);
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
