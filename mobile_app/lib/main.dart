import 'package:flutter/material.dart';
import 'product/navigation/navigation_constants.dart';
import 'product/navigation/route_generator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: NavigationConstants.HOME_VIEW,
    );
  }
}