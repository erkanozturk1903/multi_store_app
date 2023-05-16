import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SupplierOrderModel extends StatelessWidget {
  final dynamic order;
  const SupplierOrderModel({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow),
            borderRadius: BorderRadius.circular(15)),
        child: ExpansionTile(
          title: Container(
            constraints: const BoxConstraints(
              maxHeight: 80,
            ),
            width: double.infinity,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Container(
                    constraints:
                        const BoxConstraints(maxHeight: 80, maxWidth: 80),
                    child: Image.network(order['orderimage']),
                  ),
                ),
                Flexible(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['ordername'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (order['orderprice'].toStringAsFixed(2)) + ('TL'),
                          ),
                          Text(('x ') + (order['orderqty'].toString()))
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text('Devamı...'), Text(order['deliverystatus'])],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ('Adı: ') + (order['custname']),
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      ('Telefon Numarası: ') + (order['phone']),
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      ('Email Adres: ') + (order['email']),
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      ('Adres: ') + (order['address']),
                      style: const TextStyle(fontSize: 15),
                    ),
                    Row(
                      children: [
                        const Text(
                          ('Ödeme Durumu: '),
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          (order['paymentstatus']),
                          style: const TextStyle(
                              fontSize: 15, color: Colors.purple),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          ('Kargo Durumu: '),
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          (order['deliverystatus']),
                          style: const TextStyle(
                              fontSize: 15, color: Colors.green),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          ('Sipariş Tarihi: '),
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          (DateFormat('yyyy-MM-dd')
                              .format(order['orderdate'].toDate())
                              .toString()),
                          style: const TextStyle(
                              fontSize: 15, color: Colors.green),
                        ),
                      ],
                    ),
                    order['deliverystatus'] == 'Teslim edildi'
                        ? const Text('Bu sipariş zaten teslim edildi')
                        : Row(
                            children: [
                              const Text(
                                ('Teslim Durumunu Değiştir: '),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: order['deliverystatus'] == 'Hazırlanıyor'
                                    ? TextButton(
                                        onPressed: () {
                                          DatePicker.showDatePicker(
                                            context,
                                            minTime: DateTime.now(),
                                            maxTime: DateTime.now().add(
                                              const Duration(days: 365),
                                            ),
                                            onConfirm: (date) async {
                                              await FirebaseFirestore.instance
                                                  .collection('orders')
                                                  .doc(order['orderid'])
                                                  .update({
                                                'deliverystatus': 'Kargoda',
                                                'deliverydate': date,
                                              });
                                            },
                                            locale: LocaleType.tr,
                                          );
                                        },
                                        child: const Text('Kargoda ?'))
                                    : TextButton(
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('orders')
                                              .doc(order['orderid'])
                                              .update({
                                            'deliverystatus': 'Teslim Edildi',
                                          });
                                        },
                                        child: const Text('Teslim Edildi ?'),
                                      ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
