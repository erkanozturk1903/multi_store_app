// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:multi_store_app/main_screens/cart.dart';
import 'package:multi_store_app/main_screens/visit_store.dart';
import 'package:multi_store_app/minor_screens/full_screen_view.dart';
import 'package:multi_store_app/models/product_model.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/providers/wish_provider.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';
import 'package:multi_store_app/widgets/snackbar.dart';
import 'package:multi_store_app/widgets/yellow_butto.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic proList;
  const ProductDetailScreen({
    super.key,
    required this.proList,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  late List<dynamic> imageList = widget.proList['proimages'];
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg', isEqualTo: widget.proList['maincateg'])
        .where('subcateg', isEqualTo: widget.proList['subcateg'])
        .snapshots();
    return Material(
      child: SafeArea(
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenView(
                            imageList: imageList,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: Swiper(
                            pagination: const SwiperPagination(
                                builder: SwiperPagination.fraction),
                            itemBuilder: (context, index) {
                              return Image(
                                image: NetworkImage(
                                  imageList[index],
                                ),
                              );
                            },
                            itemCount: imageList.length,
                          ),
                        ),
                        Positioned(
                          left: 15,
                          top: 20,
                          child: CircleAvatar(
                            backgroundColor: Colors.yellow,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 15,
                          top: 20,
                          child: CircleAvatar(
                            backgroundColor: Colors.yellow,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.share,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      8,
                      8,
                      8,
                      50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.proList['proname'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.proList['price'].toStringAsFixed(2),
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          const Text(
                            ' TL',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<Wish>().getWishItems.firstWhereOrNull(
                                        (product) =>
                                            product.documentId ==
                                            widget.proList['proid'],
                                      ) !=
                                  null
                              ? MyMessageHandler.showSnackBar(_scaffoldKey,
                                  'Bu ürün zaten istek listesine eklenmiş')
                              : context.read<Wish>().addWishItem(
                                    widget.proList['proname'],
                                    widget.proList['price'],
                                    1,
                                    widget.proList['instock'],
                                    widget.proList['proimages'],
                                    widget.proList['proid'],
                                    widget.proList['sid'],
                                  );
                        },
                        icon: const Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    (widget.proList['instock'].toString()) +
                        (' Adet stokta mevcut'),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const ProDetailHeader(
                    label: '  Ürün Açıklaması  ',
                  ),
                  Text(
                    widget.proList['prodesc'],
                    textScaleFactor: 1.1,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey.shade800,
                    ),
                  ),
                  const ProDetailHeader(
                    label: '  Benzer Ürünler  ',
                  ),
                  SizedBox(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _productStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.yellow),
                          );
                        }

                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              'Bu kategoriye henüz ürün eklenmedi',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }

                        return SingleChildScrollView(
                          child: StaggeredGridView.countBuilder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            crossAxisCount: 2,
                            itemBuilder: (context, index) {
                              return ProductModel(
                                products: snapshot.data!.docs[index],
                              );
                            },
                            staggeredTileBuilder: (context) =>
                                const StaggeredTile.fit(1),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VisitStore(
                                suppId: widget.proList['sid'],
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.store),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartScreen(
                                back: AppBarBackButton(),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.shopping_cart),
                      ),
                    ],
                  ),
                  YellowButton(
                    label: 'Sepete Ekle',
                    onPressed: () {
                      context.read<Cart>().getItems.firstWhereOrNull(
                                    (product) =>
                                        product.documentId ==
                                        widget.proList['proid'],
                                  ) !=
                              null
                          ? MyMessageHandler.showSnackBar(
                              _scaffoldKey, 'Bu ürün zaten sepete eklenmiş')
                          : context.read<Cart>().addItem(
                                widget.proList['proname'],
                                widget.proList['price'],
                                1,
                                widget.proList['instock'],
                                widget.proList['proimages'],
                                widget.proList['proid'],
                                widget.proList['sid'],
                              );
                    },
                    width: 0.55,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProDetailHeader extends StatelessWidget {
  final String label;
  const ProDetailHeader({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
          Text(
            label,
            style: TextStyle(
                color: Colors.yellow.shade900,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
