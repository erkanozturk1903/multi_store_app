import 'package:flutter/material.dart';
import 'package:multi_store_app/dashboard_components/delivered_orders.dart';
import 'package:multi_store_app/dashboard_components/preparing_orders.dart';
import 'package:multi_store_app/dashboard_components/sipping_orders.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';

class SupplierOrders extends StatelessWidget {
  const SupplierOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const AppBarTitle(
            title: 'Siparişler',
          ),
          leading: const AppBarBackButton(),
          bottom: const TabBar(
              indicatorColor: Colors.yellow,
              indicatorWeight: 8,
              tabs: [
                RepeatedTab(label: 'Hazırlanıyor'),
                RepeatedTab(label: 'Kargoda'),
                RepeatedTab(label: 'Teslim Edildi')
              ]),
        ),
        body: const TabBarView(
          children: [
            Preparing(),
            Shipping(),
            Delivered(),
          ],
        ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(
          child: Text(
        label,
        style: const TextStyle(color: Colors.grey),
      )),
    );
  }
}
