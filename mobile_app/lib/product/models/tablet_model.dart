// ignore_for_file: unnecessary_getters_setters

class TabletModel {
  late final String _id;
  late final String _name;
  late final String _link;
  late final String _site;
  late final String _screenSize;
  late final String _img;
  late double _price;

  TabletModel();

  String get id => _id;
  void setId(String id) => _id = id;
  String get name => _name;
  String get link => _link;
  String get site => _site;
  String get screenSize => _screenSize;
  String get img => _img;
  double get price => _price;
  set price(double price) => _price = price;

  TabletModel.fromJson(Map<String, dynamic> json) {
    _name = json['product_name'];
    _link = json['link'];
    _site = "${json['site'][0].toUpperCase()}${json['site'].substring(1)}";
    _screenSize = json['screenSize'];
    _img = json['product_img'];
    _price = double.parse(json['product_price'].toString().split(' ')[0].replaceAll(".", ""));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = _name;
    data['link'] = _link;
    data['site'] = _site;
    data['screenSize'] = _screenSize;
    data['product_img'] = _img;
    data['product_price'] = _price;
    return data;
  }
}