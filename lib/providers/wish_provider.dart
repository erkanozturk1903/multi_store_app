import 'package:flutter/foundation.dart';
import 'package:multi_store_app/providers/product_class.dart';

class Wish extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getWishItems {
    return _list;
  }

  int? get count {
    return _list.length;
  }

  void addWishItem(
    String name,
    double price,
    int qty,
    int qtty,
    List imagesUrl,
    String documentId,
    String suppId,
  ) {
    final product = Product(
      name: name,
      price: price,
      qty: qty,
      qtty: qtty,
      imagesUrl: imagesUrl,
      documentId: documentId,
      suppId: suppId,
    );
    _list.add(product);
    notifyListeners();
  }

  void removeItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearWishList() {
    _list.clear();
    notifyListeners();
  }
}
