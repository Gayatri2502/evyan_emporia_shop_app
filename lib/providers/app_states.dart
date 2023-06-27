import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'server_end_product_view.dart';



DatabaseReference refference = FirebaseDatabase.instance.ref();

class StateProvider with ChangeNotifier {
  final databaseReference = FirebaseDatabase.instance.ref();

  bool isLoading = false;
  List<Product> loadedProduct = [];

  // to Add New Product

  // void saveForm() {
  //   Product newProduct = Product(
  //       Product_Id: productIdController.text,
  //       Product_name: productNameController.text,
  //       Product_description: productDescriptionController.text,
  //       Product_price: double.parse(productPriceController.text),
  //       image_url: productImageURLController.text);
  //
  //   FirebaseDatabase.instance
  //       .ref()
  //       .child("Product")
  //       .child(newProduct.Product_Id)
  //       .set(newProduct.toJson());
  // }

  // Set the Loaded data of FireBase in form of List View

  Future<void> FetchAndSetData() async {

    refference.child('Product').get().then((value) {
      loadedProduct = value.children
          .map((e) => Product.fromJson(jsonDecode(jsonEncode(e.value))))
          .toList();
    });
  }

  // print exact Details of product clicked to Edit/Save Form

  // void onEditIconPressed() {
  //   Product editDetails = Product(
  //       Product_Id: product.Product_Id,
  //       Product_name: product.Product_name,
  //       Product_description: product.Product_description,
  //       Product_price: product.Product_price,
  //       image_url: product.image_url);
  //   FirebaseDatabase.instance
  //       .ref()
  //       .child("Product")
  //       .child(editDetails.Product_Id)
  //       .set(editDetails.toJson());
  // }

  // Update the Details of Edited Product

  Future<void> updateProduct(String id, Product changedProduct) async {
    final prodIndex =
        loadedProduct.indexWhere((prod) => changedProduct.Product_Id == id);
    if (prodIndex >= 0) {}
    notifyListeners();
  }

  // Delete Products from FireBase

  Future<void> removeProductFromList() async {
       // await refference.child('Product').child(product.Product_Id).remove();
  }

}
