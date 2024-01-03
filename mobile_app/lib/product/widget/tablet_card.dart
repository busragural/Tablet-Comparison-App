import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/product/constants/utils/border_radius_constants.dart';
import 'package:mobile_app/product/constants/utils/padding_constants.dart';
import 'package:mobile_app/product/navigation/navigation_constants.dart';
import '../constants/utils/color_constants.dart';
import '../models/tablet_model.dart';

class TabletCard extends StatelessWidget {

  final TabletModel tablet;
  const TabletCard({
    super.key,
    required this.tablet,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(NavigationConstants.TABLET_DETAIL_VIEW, arguments: tablet);
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: AppPaddings.MEDIUM_V + AppPaddings.MEDIUM_H,
        decoration: BoxDecoration(
          color: const Color.fromARGB(15, 133, 200, 137),
          borderRadius: AppBorderRadius.MEDIUM,
          border: Border.all(
            color: const Color.fromARGB(20, 133, 200, 137),
            width: 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Image.network(
                tablet.img,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 11,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tablet.name,
                    style: const TextStyle(
                      color: TextColors.PRIMARY_COLOR,
                      fontSize: 16,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Website: ",
                        style: TextStyle(
                          color: TextColors.HIGHLIGHTED_COLOR,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        tablet.site,
                        style: const TextStyle(
                          color: TextColors.PRIMARY_COLOR,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          NumberFormat.currency(locale: 'eu', symbol: "TL")
                              .format(tablet.price),
                          style: const TextStyle(
                            color: TextColors.SECONDARY_COLOR,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: ButtonColors.SECONDARY_COLOR,
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.east,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
