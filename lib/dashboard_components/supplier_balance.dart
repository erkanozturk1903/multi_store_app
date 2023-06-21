import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';

class SupplierBalance extends StatelessWidget {
  const SupplierBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'SupplierBalance'),
        leading: const AppBarBackButton(),
      ),
    );
  }
}