import 'package:flutter/material.dart';
import 'package:mobile_app/product/constants/texts/screen_texts.dart';
import 'package:mobile_app/product/constants/utils/color_constants.dart';
import 'package:mobile_app/product/constants/utils/padding_constants.dart';
import 'package:mobile_app/product/constants/utils/text_styles.dart';
import 'package:mobile_app/product/widget/custom_search_bar.dart';
import 'package:mobile_app/product/widget/filter_component/filter_bottom_sheet.dart';
import 'package:mobile_app/product/widget/tablet_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: AppPaddings.MEDIUM_H + AppPaddings.SMALL_V,
          child: Column(
            children: [
              const Expanded(
                flex: 2,
                child: Padding(
                  padding: AppPaddings.MEDIUM_H,
                  child: Center(
                    child: Text(ScreenTexts.HOME_TEXT,
                        textAlign: TextAlign.center,
                        style: TextStyles.HOME_HEADING),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    const Expanded(
                      child: CustomSearchBar(),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return const FilterBottomSheet();
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.filter_list_rounded,
                        size: 30,
                        color: AssetColors.SECONDARY_COLOR,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: TabletCard(
                        imageUrl:
                            "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTp_w3Y6oO4Cwac1agH0yqvp9nii0wlRF_aUWlNQyciiNarWd3Xpq0WfSx7xcwmCsvopAi3TQF_GpblmFrPbC1nhk0Zv1pbhkKNrFoJ_4UYT7w3q11Oh6QZdA&usqp=CAE",
                        tabletModel:
                            "Apple iPad 10. Nesil 10.9\" Wifi 64GB Mavi Tablet MPQ13TU/A",
                        leastPriceSite: "Teknosa",
                        price: 11999,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
