// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/dashboard_components/edit_profile.dart';
import 'package:multi_store_app/dashboard_components/manage_products.dart';
import 'package:multi_store_app/dashboard_components/suppl_balance.dart';
import 'package:multi_store_app/dashboard_components/suppl_orders.dart';
import 'package:multi_store_app/dashboard_components/suppl_statics.dart';
import 'package:multi_store_app/main_screens/visit_store.dart';
import 'package:multi_store_app/widgets/alert_dialog.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';

List<String> label = [
  'Dükkanım',
  'Siparisler',
  'Profil Düzenle',
  'Ürün Yönetimi',
  'Bakiye',
  'Istatistik'
];

List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart,
];

List<Widget> pages = [
  VisitStore(
    suppId: FirebaseAuth.instance.currentUser!.uid,
  ),
  const SupplierOrders(),
  const EditBusiness(),
  const ManageProducts(),
  const SupplierBalance(),
  const StaticsScreen()
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Dasboard'),
        actions: [
          IconButton(
            onPressed: () {
              MyAlertDialog.showMyDialog(
                  context: context,
                  title: 'Çıkış Yap',
                  content: 'Çıkmak istediğinizden emin misin?',
                  tabNo: () {
                    Navigator.pop(context);
                  },
                  tabYes: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/welcome_screen');
                  });
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
          mainAxisSpacing: 50,
          crossAxisSpacing: 50,
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => pages[index],
                  ),
                );
              },
              child: Card(
                elevation: 20,
                shadowColor: Colors.purpleAccent.shade200,
                color: Colors.blueGrey.withOpacity(0.7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      icons[index],
                      size: 50,
                      color: Colors.yellowAccent,
                    ),
                    Text(
                      label[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                        fontFamily: 'Acme',
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
