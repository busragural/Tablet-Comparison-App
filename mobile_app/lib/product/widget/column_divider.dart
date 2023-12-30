import 'package:flutter/material.dart';

class ColumnDivider extends StatelessWidget {
  const ColumnDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(15, 0, 0, 0))),
      ),
    );
  }
}
