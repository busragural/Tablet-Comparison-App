import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/product/constants/texts/screen_texts.dart';
import 'package:mobile_app/product/constants/utils/color_constants.dart';
import 'package:mobile_app/product/constants/utils/padding_constants.dart';
import 'package:mobile_app/product/constants/utils/text_styles.dart';
import 'package:mobile_app/product/models/tablet_model.dart';
import 'package:mobile_app/product/widget/custom_search_bar.dart';
import 'package:mobile_app/product/widget/filter_component/filter_bottom_sheet.dart';
import 'package:mobile_app/product/widget/tablet_card.dart';
import 'package:mobile_app/product/widget/update_bottom_sheet.dart';
import 'package:mobile_app/services/firestore.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return const UpdateBottomSheet();
                  },
                );
              },
              icon: const Icon(
                Icons.update,
                color: AssetColors.SECONDARY_COLOR,
                size: 35,
              ),
            ),
            const SizedBox(
              width: 5,
            )
          ],
        ),
        body: Padding(
          padding: AppPaddings.MEDIUM_H + const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              const Expanded(
                flex: 3,
                child: Center(
                  child: Text(ScreenTexts.HOME_TEXT,
                      textAlign: TextAlign.center,
                      style: TextStyles.HOME_HEADING),
                ),
              ),
              Expanded(
                flex: 2,
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
                flex: 14,
                child: StreamBuilder(
                  stream: firestoreService.getTabletsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    if (snapshot.hasData) {
                      List tabletList = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: tabletList.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot document = tabletList[index];
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          TabletModel tablet = TabletModel.fromJson(data);
                          tablet.setId(document.id);
                          return Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: TabletCard(
                              imageUrl: tablet.img,
                              tabletModel: tablet.name,
                              ownerWebsite: tablet.site,
                              price: tablet.price,
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text("Tablet bulunamadı");
                    }
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
