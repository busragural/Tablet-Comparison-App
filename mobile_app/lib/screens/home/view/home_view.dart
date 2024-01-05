import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_app/product/constants/texts/screen_texts.dart';
import 'package:mobile_app/product/constants/utils/color_constants.dart';
import 'package:mobile_app/product/constants/utils/padding_constants.dart';
import 'package:mobile_app/product/constants/utils/text_styles.dart';
import 'package:mobile_app/product/models/tablet_model.dart';
import 'package:mobile_app/product/widget/custom_search_bar.dart';
import 'package:mobile_app/product/widget/filter_component/filter_bottom_sheet.dart';
import 'package:mobile_app/product/widget/tablet_card.dart';
import 'package:mobile_app/product/widget/update_bottom_sheet.dart';
import 'package:mobile_app/screens/home/viewmodel/home_viewmodel.dart';
import 'package:mobile_app/services/firestore.dart';

import '../../../core/base/view/base_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController leastPriceController = TextEditingController();
  final TextEditingController mostPriceController = TextEditingController();
  late HomeViewModel viewModel;

  _searchTablets() {
    if (_searchController.text != "") {
      viewModel.clearResultTablets();
      for (var tabletSnapshot in viewModel.filterResults) {
        var name = tabletSnapshot["product_name"].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          viewModel.addResultTablets(tabletSnapshot);
        }
      }
    } else {
      viewModel.updateResultTablets(viewModel.filterResults);
    }
  }

  @override
  void initState() {
    viewModel = HomeViewModel();
    viewModel.getAllTablets().then((value) => viewModel.initTabletLists());
    _searchController.addListener(_searchTablets);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _searchTablets();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BaseStatefulView<HomeViewModel>(
      viewModel: viewModel,
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      onPageBuilder: (context, value) => buildPage(context),
    );
  }

  SafeArea buildPage(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          actions: [IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomeView()));
              },
              icon: const Icon(
                Icons.system_security_update_rounded,
                color: AssetColors.SECONDARY_COLOR,
                size: 35,
              ),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return UpdateBottomSheet();
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
                    Expanded(
                      child: CustomSearchBar(
                        searchController: _searchController,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return FilterBottomSheet(
                              viewModel: viewModel,
                              leastPriceController: leastPriceController,
                              mostPriceController: mostPriceController,
                            );
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
                flex: 15,
                child: Observer(builder: (_) {
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${viewModel.resultCount} sonuç gösteriliyor...",
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 14,
                        child: ListView.builder(
                          itemCount: viewModel.resultTablets.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document =
                                viewModel.resultTablets[index];
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            TabletModel tablet = TabletModel.fromJson(data);
                            tablet.setId(document.id);
                            return Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: TabletCard(
                                tablet: tablet,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
