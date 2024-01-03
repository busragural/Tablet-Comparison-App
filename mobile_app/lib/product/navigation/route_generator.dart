import 'package:flutter/material.dart';
import 'package:mobile_app/product/models/tablet_model.dart';
import 'package:mobile_app/screens/tablet_detail/view/tablet_detail_view.dart';
import 'navigation_constants.dart';
import '../../screens/home/view/home_view.dart';

class RouteGenerator {
  RouteGenerator._init();
  static RouteGenerator? _instance;
  static RouteGenerator get instance {
    _instance ??= RouteGenerator._init();
    return _instance!;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case NavigationConstants.HOME_VIEW:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case NavigationConstants.TABLET_DETAIL_VIEW:
        final args = settings.arguments as TabletModel;
        return MaterialPageRoute(builder: (_) => TabletDetailView(args));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
