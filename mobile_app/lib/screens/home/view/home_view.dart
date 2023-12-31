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
  final TextEditingController _searchController = TextEditingController();
  List _allTablets = [];
  List _tabletResults = [];
  int resultCount = 0;

  _searchTablets() {
    var foundTablets = [];

    if (_searchController.text != "") {
      for (var tabletSnapshot in _allTablets) {
        var name = tabletSnapshot["product_name"].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          foundTablets.add(tabletSnapshot);
        }
      }
    } else {
      foundTablets = List.from(_allTablets);
    }

    setState(() {
      _tabletResults = foundTablets;
      resultCount = foundTablets.length;
    });
  }

  getTabletStream() async {
    var data = await firestoreService.getTablets();
    setState(() {
      _allTablets = data.docs;
    });
    _searchTablets();
  }

  @override
  void initState() {
    _searchController.addListener(_searchTablets);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    getTabletStream();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchController.removeListener(_searchTablets);
    _searchController.dispose();
    super.dispose();
  }

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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "$resultCount sonuç gösteriliyor...",
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                flex: 14,
                child: ListView.builder(
                  itemCount: _tabletResults.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot document = _tabletResults[index];
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
