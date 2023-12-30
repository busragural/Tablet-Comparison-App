// ignore_for_file: unnecessary_getters_setters

class TabletModel {
  late final String _id;
  late final String _name;
  late final String _photoUrl;
  late double _lowPrice;

  TabletModel({required String id, required String name, required String photoUrl, required double price}) {
      _name = name;
      _name = name;
      _photoUrl = photoUrl;
      _lowPrice = price;
  }

  String get id => _id;
  String get name => _name;
  String get photoUrl => _photoUrl;
  double get price => _lowPrice;
  set price(double price) => _lowPrice = price;

  TabletModel.fromJson(Map<String, dynamic> json) {
    _name = json['id'];
    _name = json['name'];
    _photoUrl = json['photoUrl'];
    _lowPrice = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['photoUrl'] = _photoUrl;
    data['price'] = _lowPrice;
    return data;
  }
}