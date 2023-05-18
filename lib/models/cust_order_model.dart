// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerOrderModel extends StatelessWidget {
  final dynamic order;
  const CustomerOrderModel({
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
                //height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: order['deliverystatus'] == 'delivered'
                      ? Colors.brown.withOpacity(0.2)
                      : Colors.yellow.withOpacity(0.2),
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
                    order['deliverystatus'] == 'Kargoda'
                        ? Text(
                            ('Tahmini Teslim Tarihi :') +
                                (DateFormat('yyyy-MM-dd')
                                        .format(order['deliverydate'].toDate()))
                                    .toString(),
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          )
                        : const Text(''),
                    order['deliverystatus'] == 'delivered' &&
                            order['orderrewiew'] == false
                        ? TextButton(
                            onPressed: () {}, child: const Text('İnceleme Yaz'))
                        : const Text(''),
                    order['deliverystatus'] == 'delivered' &&
                            order['orderrewiew'] == true
                        ? Row(
                            children: const [
                              Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                              Text(
                                'Sepeti Gözden Geçir',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.blue,
                                ),
                              )
                            ],
                          )
                        : const Text('')
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
