import 'package:evyan_emporia_shop_app/providers/server_end_product_view.dart';


class Cart {
  Product product;
  int quantity;

  Cart({
    required this.product,
    required this.quantity,
  });
//from Json
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        product: Product.fromJson(json['product']), quantity: json['quantity']);
  }

//to Json
  Map<String, dynamic> toJson() {
    return {'product': product.toJson(), 'quantity': quantity};
  }
}

// class CartProvider with ChangeNotifier {
//   Map<String, CartGridItem> Items = {};
//   final List<CartGridItem> _Identity = [];
//
//   List<CartGridItem> get Identity {
//     return _Identity;
//   }
//
//   Future<void> removeSingleItem(String id) async {
//     print("Items length: ${Items.length}");
//     if (!Items.containsKey(id)) {
//       return;
//     }
//     if (Items[id]!.quantity > 1) {
//       Items.update(id, (Identity) => CartGridItem(Identity.product, 1, () {}));
//     } else {
//       Items.remove(id);
//     }
//     print("Items length: ${Items.length}");
//     notifyListeners();
//   }


