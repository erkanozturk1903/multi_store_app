import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/models/supp_order_model.dart';

class Delivered extends StatelessWidget {
  const Delivered({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('deliverystatus', isEqualTo: 'delivered')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.yellow),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'Aktif Siparişin Yok...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return SupplierOrderModel(
                order: snapshot.data!.docs[index],
              );
            });
      },
    );
  }
}
