import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'server_end_product_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  final List<Product> _items = [
    //   Product(
    //       Product_Id: '101',
    //       Product_name: 'Autum Shoes',
    //       Product_description: 'Casual Shoes',
    //       Product_price: 799.00,
    //       image_url:
    //           '103'),
    //   Product(
    //       Product_Id: '102',
    //       Product_name: 'shoes',
    //       Product_description: 'adidas',
    //       Product_price: 899.00,
    //       image_url:
    //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0KLpxgwL764PoPBlZbwqdelC3QdM7Xx_w3Q&usqp=CAU'),
    //   Product(
    //       Product_Id: '103',
    //       Product_name: 'Z-High shoe',
    //       Product_description: 'KOR',
    //       Product_price: 1299.00,
    //       image_url:
    //           'https://i.pinimg.com/736x/88/74/e7/8874e7a0aace168049eafde28427ce8f.jpg'),
    //   Product(
    //       Product_Id: '104',
    //       Product_name: 'Adidas Shoes',
    //       Product_description: 'Adidas',
    //       Product_price: 875.00,
    //       image_url:
    //           'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/09c5ea6df1bd4be6baaaac5e003e7047_9366/Forum_Low_Shoes_White_FY7756_01_standard.jpg'),
    //   Product(
    //       Product_Id: '105',
    //       Product_name: 'Jordan Shoes',
    //       Product_description: 'Jordan',
    //       Product_price: 999.00,
    //       image_url:
    //           'https://rukminim1.flixcart.com/image/450/500/xif0q/shoe/t/z/c/8-ozz4-8-laststep-black-original-imageyhgkg56xrff-bb.jpeg?q=90&crop=false'),
    //   Product(
    //       Product_Id: '106',
    //       Product_name: 'Girl-Jordan',
    //       Product_description: 'Jordan Shoes',
    //       Product_price: 2983.00,
    //       image_url:
    //           'https://images.complex.com/complex/images/c_scale,f_auto,q_auto,w_1920/fl_lossy,pg_1/n9mhxly6ltmwiinrmzu5/wmns-air-jordan-1-retro-high-atmpsphere-lead?fimg-ssr-default'),
    //   Product(
    //       Product_Id: '107',
    //       Product_name: 'Shoes',
    //       Product_description: 'Jordans',
    //       Product_price: 789.00,
    //       image_url:
    //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6DQJZD1kZfisIsHHkTAmos3QSd1_eHOQq6Q&usqp=CAU'),
    //   Product(
    //       Product_Id: '108',
    //       Product_name: 'Girls-Nike-Wear',
    //       Product_description: 'Nike',
    //       Product_price: 1389.00,
    //       image_url:
    //           'https://www.highsnobiety.com/static-assets/thumbor/LDHAQ2_l0uNclEe7CY2aASE96Jc=/1200x800/www.highsnobiety.com/static-assets/wp-content/uploads/2021/01/15142607/valuable-Jordan-sneakers-ebay-main1.jpg'),
  ];

  

  get length => Product.length;

  List<Product> get items {
    return _items;
  }



  void addProducts(Product newProduct) {
    var url = Uri.parse(
        'https://shop-app-9df44-default-rtdb.firebaseio.com/Product.json');
    http.post(url,
        body: json.encode({
          'Product_Id': newProduct.Product_Id,
          'Product_name': newProduct.Product_name,
          'Product_description': newProduct.Product_description,
          'Product_price': newProduct.Product_price,
          'image_url': newProduct.image_url,
          'isFavorite': newProduct.isFavorite,
        }));

    _items.add(newProduct);
    notifyListeners();
  }


  List<Product> shoppingCartGridItems = [];

  Future<void> addProductToCart(Product product) async {
    /*var url = Uri.parse('https://shop-app-9df44-default-rtdb.firebaseio.com/OrderDetails.json' );
    http.post(url,body: json.encode({
      'ID' : product.Product_Id,
      'Name': product.Product_name,
      'price': product.Product_price,
      'Quantity':product.Quantity
    }));
*/
    FirebaseDatabase.instance
        .ref()
        .child('OrderDetails')
        .child(product.Product_Id)
        .get()
        .then((value) {
      if (value.exists) {
        Product oldProduct =
            Product.fromJson(jsonDecode(jsonEncode(value.value)));
        Product newProduct = Product(
          Product_Id: oldProduct.Product_Id,
          Product_name: oldProduct.Product_name,
          Product_description: oldProduct.Product_description,
          Product_price: oldProduct.Product_price,
          image_url: oldProduct.image_url,
          quantity: oldProduct.quantity + 1,
          isFavorite: oldProduct.isFavorite,
        );
        FirebaseDatabase.instance
            .ref()
            .child('OrderDetails')
            .child(product.Product_Id)
        .set(newProduct.toJson());
      }
      else{
        FirebaseDatabase.instance
            .ref()
            .child('OrderDetails')
            .child(product.Product_Id)
            .set(product.toJson());
      }
    });
    //shoppingCartGridItems.add(product);
    //notifyListeners();
    // shoppingCartGridItems.add(product);
    // shoppingCartGridItems.toSet().toList();
    // notifyListeners();
  }



  Future<void> removeSingleProductFromCart(Product product) async {
    FirebaseDatabase.instance
        .ref()
        .child('OrderDetails')
        .child(product.Product_Id).remove();
  }


  Product? findById(String ProductId) {
    if (_items.isNotEmpty) {
      return _items.firstWhere((prod) => prod.Product_Id == ProductId);
    }
  }
  
  
  // //bool showFavorites = false;
  //
  // void toggleShowFavorite(bool value ) {
  //  // showFavorites= value;
  //   if (value == true){
  //     FirebaseDatabase.instance.ref().child('FavoriteItems').onValue;
  //   }
  //   else{
  //     FirebaseDatabase.instance.ref().child('Product').onValue;
  //   }
// }

  // List<Product> get favoriteItems {
  //   return showFavorites
  //       ? _items.where((ProdItem) => ProdItem.isFavorite).toList()
  //       : _items;
  // }
  void toggleFavorite(int index) {
    Product newProduct = Product(
        Product_Id: _items[index].Product_Id,
        Product_name: _items[index].Product_name,
        Product_description: _items[index].Product_description,
        Product_price: _items[index].Product_price,
        image_url: _items[index].image_url,
        isFavorite: !_items[index].isFavorite);
    _items.replaceRange(index, index + 1, [newProduct]);
    notifyListeners();
  }


}

// if (showFavorites){
// return _items.where((ProdItem) => ProdItem.isFavorite).toList();
// }
