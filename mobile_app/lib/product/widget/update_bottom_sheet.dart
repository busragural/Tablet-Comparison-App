// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/core/base/state/base_state.dart';
import 'package:mobile_app/product/constants/utils/padding_constants.dart';
import 'package:mobile_app/services/flask.dart';

import '../constants/utils/color_constants.dart';

class UpdateBottomSheet extends BaseStatelessWidget {
  final FlaskService flaskService = FlaskService();
  UpdateBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dynamicHeightDevice(context, 0.35),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WebsiteUpdateCard(website: "Mediamarkt", service: flaskService),
            WebsiteUpdateCard(website: "Vatan", service: flaskService),
            WebsiteUpdateCard(website: "Teknosa", service: flaskService),
          ],
        ),
      ),
    );
  }
}

class WebsiteUpdateCard extends StatefulWidget {
  final String website;
  final FlaskService service;
  const WebsiteUpdateCard({
    super.key,
    required this.website,
    required this.service,
  });

  @override
  State<WebsiteUpdateCard> createState() => _WebsiteUpdateCardState();
}

class _WebsiteUpdateCardState extends BaseState<WebsiteUpdateCard> {
  DateTime scrapedTime = DateTime.now().subtract(const Duration(hours: 48));
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.website,
                style: TextStyle(
                  color: TextColors.PRIMARY_COLOR,
                  fontSize: dynamicHeightDevice(0.03),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "En son güncelleme: ${DateFormat('dd-MM-yyyy').format(scrapedTime)}",
                style: TextStyle(
                  color: TextColors.PRIMARY_COLOR,
                  fontSize: dynamicHeightDevice(0.015),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            widget.service.runScraper(widget.website);
            setState(() {
              scrapedTime = DateTime.now();
            });
          },
          icon: const Icon(
            Icons.update,
            color: ButtonColors.PRIMARY_COLOR,
            size: 35,
          ),
        ),
        // EnableWebsiteSwitch(),
      ],
    );
  }
}

// class EnableWebsiteSwitch extends StatefulWidget {
//   const EnableWebsiteSwitch({
//     super.key,
//   });

//   @override
//   State<EnableWebsiteSwitch> createState() => _EnableWebsiteSwitchState();
// }

// class _EnableWebsiteSwitchState extends State<EnableWebsiteSwitch> {
//   bool isEnable = true;
//   @override
//   Widget build(BuildContext context) {
//     return Switch(
//       value: isEnable,
//       activeColor: ButtonColors.PRIMARY_COLOR,
//       onChanged: (bool value) {
//         setState(() {
//           isEnable = value;
//         });
//         print(isEnable);
//       },
//     );
//   }
// }
