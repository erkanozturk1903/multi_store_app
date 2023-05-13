// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/providers/product_class.dart';
import 'package:multi_store_app/providers/wish_provider.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class CartModel extends StatelessWidget {
  const CartModel({
    super.key,
    required this.product,
    required this.cart,
  });

  final Product product;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              SizedBox(
                height: 100,
                width: 120,
                child: Image.network(
                  product.imagesUrl.first,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.price.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  product.qty == 1
                                      ? IconButton(
                                          onPressed: () {
                                            showCupertinoModalPopup<void>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CupertinoActionSheet(
                                                title: const Text('Ürünü Sil'),
                                                message: const Text(
                                                    'Ürünü silmek istediğinizden emin misiniz?'),
                                                actions: <
                                                    CupertinoActionSheetAction>[
                                                  CupertinoActionSheetAction(
                                                    onPressed: () async {
                                                      context
                                                                  .read<Wish>()
                                                                  .getWishItems
                                                                  .firstWhereOrNull((element) =>
                                                                      element
                                                                          .documentId ==
                                                                      product
                                                                          .documentId) !=
                                                              null
                                                          ? context
                                                              .read<Cart>()
                                                              .removeItem(
                                                                  product)
                                                          : await context
                                                              .read<Wish>()
                                                              .addWishItem(
                                                                product.name,
                                                                product.price,
                                                                1,
                                                                product.qtty,
                                                                product
                                                                    .imagesUrl,
                                                                product
                                                                    .documentId,
                                                                product.suppId,
                                                              );
                                                      context
                                                          .read<Cart>()
                                                          .removeItem(product);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                        'İstek Listesine Taşı'),
                                                  ),
                                                  CupertinoActionSheetAction(
                                                    isDestructiveAction: true,
                                                    onPressed: () {
                                                      context
                                                          .read<Cart>()
                                                          .removeItem(product);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Sil'),
                                                  ),
                                                ],
                                                cancelButton: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    'Kapat',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete_forever,
                                            size: 18,
                                          ),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            cart.reduceByOne(product);
                                          },
                                          icon: const Icon(
                                            FontAwesomeIcons.minus,
                                            size: 18,
                                          ),
                                        ),
                                  Text(
                                    product.qty.toString(),
                                    style: product.qty == product.qtty
                                        ? const TextStyle(
                                            fontSize: 20,
                                            color: Colors.red,
                                            fontFamily: 'Acme')
                                        : const TextStyle(
                                            fontSize: 20, fontFamily: 'Acme'),
                                  ),
                                  IconButton(
                                    onPressed: product.qty == product.qtty
                                        ? null
                                        : () {
                                            cart.increment(product);
                                          },
                                    icon: const Icon(
                                      FontAwesomeIcons.plus,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
