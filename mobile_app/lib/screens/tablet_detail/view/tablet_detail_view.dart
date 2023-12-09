import 'package:flutter/material.dart';
import 'package:mobile_app/core/base/state/base_state.dart';
import 'package:mobile_app/product/widget/column_divider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../product/constants/utils/border_radius_constants.dart';
import '../../../product/constants/utils/color_constants.dart';
import '../../../product/constants/utils/padding_constants.dart';

class TabletDetailView extends BaseStatelessWidget {
  final Uri _url = Uri.parse(
      "https://www.teknosa.com/apple-ipad-10-nesil-109-wifi-64gb-mavi-tablet-mpq13tua-p-125046643");
  TabletDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: AppPaddings.MEDIUM_H + AppPaddings.SMALL_V,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTp_w3Y6oO4Cwac1agH0yqvp9nii0wlRF_aUWlNQyciiNarWd3Xpq0WfSx7xcwmCsvopAi3TQF_GpblmFrPbC1nhk0Zv1pbhkKNrFoJ_4UYT7w3q11Oh6QZdA&usqp=CAE",
                ),
              ),
              Padding(
                padding: AppPaddings.MEDIUM_V + AppPaddings.LARGE_H,
                child: const Text(
                  "Apple iPad 10. Nesil 10.9\" Wifi 64GB Mavi Tablet MPQ13TU/A",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: TextColors.PRIMARY_COLOR,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: dynamicHeightDevice(context, 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    3,
                    (index) => InkWell(
                      overlayColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      onTap: _launchUrl,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ButtonColors.PRIMARY_COLOR,
                              borderRadius: AppBorderRadius.LARGE,
                            ),
                            child: Padding(
                              padding:
                                  AppPaddings.SMALL_V + AppPaddings.SMALL_H,
                              child: const Text(
                                "Teknosa",
                                style: TextStyle(
                                  color: TextColors.BUTTON_TEXT_COLOR,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "11.199 TL",
                            style: TextStyle(
                              color: TextColors.PRIMARY_COLOR,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const ColumnDivider(),
              const Padding(
                padding: AppPaddings.SMALL_V,
                child: Text(
                  "Özellikler",
                  style: TextStyle(
                    color: TextColors.PRIMARY_COLOR,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) {
                    return const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 9,
                          child: Text(
                            "Marka:",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: TextColors.HIGHLIGHTED_COLOR,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 9,
                          child: Text(
                            "Apple",
                            style: TextStyle(
                              color: TextColors.PRIMARY_COLOR,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
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

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
