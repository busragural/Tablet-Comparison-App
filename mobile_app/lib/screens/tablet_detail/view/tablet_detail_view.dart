import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/core/base/state/base_state.dart';
import 'package:mobile_app/product/models/tablet_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../product/constants/utils/border_radius_constants.dart';
import '../../../product/constants/utils/color_constants.dart';
import '../../../product/constants/utils/padding_constants.dart';

// ignore: must_be_immutable
class TabletDetailView extends BaseStatelessWidget {
  late Uri _url;
  final TabletModel tablet;
  TabletDetailView(this.tablet, {super.key}) {
    _url = Uri.parse(tablet.link);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: AppPaddings.MEDIUM_H + AppPaddings.SMALL_V,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.network(tablet.img),
              ),
              Padding(
                padding: AppPaddings.MEDIUM_V + AppPaddings.LARGE_H,
                child: Text(
                  tablet.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: TextColors.PRIMARY_COLOR,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: dynamicHeightDevice(context, 0.1),
                child: InkWell(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  onTap: _launchUrl,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ButtonColors.PRIMARY_COLOR,
                      borderRadius: AppBorderRadius.LARGE,
                    ),
                    child: Padding(
                      padding: AppPaddings.SMALL_V + AppPaddings.SMALL_H,
                      child: Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tablet.site,
                                  style: TextStyle(
                                    color: TextColors.BUTTON_TEXT_COLOR,
                                    fontSize:
                                        dynamicHeightDevice(context, 0.028),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  NumberFormat.currency(
                                          locale: 'eu', symbol: "TL")
                                      .format(tablet.price),
                                  style: TextStyle(
                                    color: TextColors.BUTTON_TEXT_COLOR,
                                    fontSize:
                                        dynamicHeightDevice(context, 0.023),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                            child: Icon(
                              Icons.add_shopping_cart_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          const Spacer()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(flex: 4, child: Center()),
              // const Padding(
              //   padding: AppPaddings.MEDIUM_V,
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       "Özellikler",
              //       style: TextStyle(
              //         color: TextColors.PRIMARY_COLOR,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 24,
              //       ),
              //     ),
              //   ),
              // ),
              // Expanded(
              //   flex: 4,
              //   child: Column(
              //     children: [
              //       buildPropertyRow("Boyut", tablet.screenSize, "inç"),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildPropertyRow(String label, String value, String measureUnit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 9,
          child: Text(
            label,
            style: const TextStyle(
              color: TextColors.HIGHLIGHTED_COLOR,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: Text(
            "$value $measureUnit",
            style: const TextStyle(
              color: TextColors.PRIMARY_COLOR,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
