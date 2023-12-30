import 'package:flutter/material.dart';
import 'package:mobile_app/core/base/state/base_state.dart';
import 'package:mobile_app/product/constants/utils/padding_constants.dart';
import 'package:mobile_app/product/widget/custom_filled_button.dart';
import 'package:mobile_app/product/widget/column_divider.dart';
import 'package:mobile_app/product/widget/filter_component/filter_price.dart';
import '../../constants/utils/color_constants.dart';
import 'filter_multiple_checkbox.dart';

class FilterBottomSheet extends BaseStatelessWidget {
  const FilterBottomSheet({super.key});

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
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FilterPrice(),
                    ColumnDivider(),
                    FilterMultipleCheckbox(
                      filterType: "Marka",
                      choices: [
                        "Apple", "Samsung", "Huawei", "Vestel", "Xiomi", "Lenovo", "Casper", "Oppo"
                      ],
                    ),
                    ColumnDivider(),
                    FilterMultipleCheckbox(
                      filterType: "Boyut",
                      choices: [
                        "10.9", "11", "12.4", "8", "11.7",
                      ],
                    ),
                    ColumnDivider(),
                    FilterMultipleCheckbox(
                      filterType: "Renk",
                      choices: [
                        "Siyah", "Gri", "Beyaz", "Pembe", "Mor", "Kırmızı", "Mavi", "Gümüş"
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
                onTap: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
