import 'dart:convert';

import 'package:evyan_emporia_shop_app/widgets/each_tile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/product_provider.dart';
import '../providers/server_end_product_view.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    Key? key,
  }) : super(key: key);

  // const ProductGrid({Key? key, required this.Loaded_products})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<DatabaseEvent>(
            stream: FirebaseDatabase.instance.ref().child('Product').onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> allItems = snapshot.data!.snapshot.children
                    .map<Product>((item) =>
                        Product.fromJson(jsonDecode(jsonEncode(item.value))))
                    .toList();
                return GridView.builder(

                  padding: const EdgeInsets.all(10),
                  itemCount: allItems.length,
                  itemBuilder: (ctx, i) => ProductItems(
                    onShoppingCartButtonPressed: () {
                      Provider.of<ProductProvider>(context, listen: false)
                          .addProductToCart(allItems[i]);
                    },
                    product: allItems[i],
                    onFavoritePressed: () {
                      FirebaseDatabase.instance
                          .ref()
                          .child("FavoriteItems")
                          .child(allItems[i].Product_Id)
                          .get()
                          .then((value) {
                        if (value.exists) {
                          FirebaseDatabase.instance
                              .ref()
                              .child("FavoriteItems")
                              .child(allItems[i].Product_Id)
                              .remove();
                        } else {
                          FirebaseDatabase.instance
                              .ref()
                              .child("FavoriteItems")
                              .child(allItems[i].Product_Id)
                              .set(allItems[i].toJson());
                        }
                      });
                    },
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                );
              }
              return Container();
            }));
  }
}
