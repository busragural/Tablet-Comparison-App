import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

import '../../../services/firestore.dart';
part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase extends BaseViewModel with Store {
  final FirestoreService firestoreService = FirestoreService();

  List<DocumentSnapshot> allTablets = [];
  List<DocumentSnapshot> filterResults = [];

  Map<String, bool> brandMap = {
    'filterActive': false,
    'apple': false,
    'samsung': false,
    'huawei': false,
    'xiomi': false,
    'lenovo': false,
    'casper': false,
  };

  Map<String, bool> sizeMap = {
    'filterActive': false,
    '10_9 inç': false,
    '11 inç': false,
    '12_9 inç': false,
    '8 inç': false,
    '11_7 inç': false,
  };

  Map<String, bool> siteMap = {
    'filterActive': false,
    'vatan': false,
    'mediamarkt': false,
    'teknosa': false,
  };

  @observable
  List<DocumentSnapshot> resultTablets = [];

  @observable
  int resultCount = 0;

  @observable
  Map<String, Map<String, bool>> choiceFilters = {};

  @observable
  List<String> priceFilter = [];

  _HomeViewModelBase() {
    init();
  }

  @override
  void init() {
    choiceFilters = {
      'marka': brandMap,
      'boyut': sizeMap,
      'site': siteMap,
    };
  }

  Future<void> getAllTablets() async {
    final data = await firestoreService.getTablets();
    allTablets = data.docs;
  }

  @action
  void addResultTablets(DocumentSnapshot tabletSnapshot) {
    resultTablets.add(tabletSnapshot);
    resultCount = resultTablets.length;
  }

  @action
  void initTabletLists() {
    updateResultTablets(allTablets);
    filterResults = List.from(allTablets);
  }

  @action
  void clearResultTablets() {
    resultTablets.clear();
    resultCount = resultTablets.length;
  }

  @action
  void updateResultTablets(List<DocumentSnapshot> resultList) {
    resultTablets = List.from(resultList);
    resultCount = resultTablets.length;
  }

  @action
  void changeCheckboxFilter(
      String filterKey, String choiceKey, bool isSelected) {
    filterKey = filterKey.toLowerCase();
    choiceKey = choiceKey.toLowerCase().replaceAll(".", "_");
    Map<String, bool> filterMap = choiceFilters[filterKey]!;
    filterMap[choiceKey] = isSelected;
    filterMap["filterActive"] = false;
    for (var option in filterMap.values) {
      if (option == true) {
        filterMap["filterActive"] = true;
        break;
      }
    }
  }

  @action
  Future<void> filterTablets(
    TextEditingController leastPriceController,
    TextEditingController mostPriceController,
  ) async {
    List<String> tabletIds = [];
    List<String> tmpIds = [];
    List<String> filterTabletIds = [];
    Map<String, bool> filterMap;
    for (DocumentSnapshot tabletSnapshot in allTablets) {
      tabletIds.add(tabletSnapshot.id);
    }
    for (var choiceFilterKey in choiceFilters.keys) {
      filterMap = choiceFilters[choiceFilterKey]!;
      if (filterMap["filterActive"] == true) {
        tmpIds = [];
        for (var filterMapKey in filterMap.keys) {
          if (filterMap[filterMapKey] == true) {
            if (filterMapKey.compareTo("filterActive") != 0) {
              filterTabletIds =
                  await firestoreService.getFilterTabletIds(filterMapKey);
              tmpIds = List.from(tmpIds)..addAll(filterTabletIds);
            }
          }
        }
        tabletIds.removeWhere((element) => !tmpIds.contains(element));
      }
    }

    filterResults = List.of(allTablets);
    filterResults.removeWhere((element) => !tabletIds.contains(element.id));
    if (leastPriceController.text != "") {
      double leastPrice = double.parse(leastPriceController.text);
      filterResults.removeWhere((element) => double.parse(element["product_price"]) < leastPrice);
    }
    if (mostPriceController.text != "") {
      double mostPrice = double.parse(mostPriceController.text);
      filterResults.removeWhere((element) => double.parse(element["product_price"]) > mostPrice);
    }
    updateResultTablets(filterResults);
  }

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }
}
