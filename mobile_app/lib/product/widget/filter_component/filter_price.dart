import 'package:flutter/material.dart';
import 'package:mobile_app/core/base/state/base_state.dart';
import 'package:mobile_app/product/constants/utils/padding_constants.dart';
import 'package:mobile_app/product/widget/filter_component/price_textfield.dart';
import '../../constants/utils/color_constants.dart';

class FilterPrice extends BaseStatelessWidget {
  final TextEditingController leastPriceController;
  final TextEditingController mostPriceController;
  const FilterPrice(this.leastPriceController, this.mostPriceController,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Fiyat Aralığı",
          style: TextStyle(
            color: TextColors.PRIMARY_COLOR,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(
            height: dynamicHeightDevice(context, 0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: PriceTextField(
                  hintText: "En az",
                  priceController: leastPriceController,
                )),
                const Padding(
                  padding: AppPaddings.LARGE_H,
                  child: Text(
                    "-",
                    style: TextStyle(
                      color: TextColors.PRIMARY_COLOR,
                      fontSize: 32,
                    ),
                  ),
                ),
                Expanded(
                    child: PriceTextField(
                  hintText: "En çok",
                  priceController: mostPriceController,
                )),
              ],
            )),
      ],
    );
  }
}
