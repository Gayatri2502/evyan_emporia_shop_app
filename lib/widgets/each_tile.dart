import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../providers/server_end_product_view.dart';
import '../screens/EachItemDetails.dart';

class ProductItems extends StatefulWidget {
  final Product product;
  final Function() onShoppingCartButtonPressed;
  final Function() onFavoritePressed;

  const ProductItems({
    Key? key,
    required this.product,
    required this.onShoppingCartButtonPressed,
    required this.onFavoritePressed,
  }) : super(key: key);

  @override
  State<ProductItems> createState() => _ProductItemsState();
}

class _ProductItemsState extends State<ProductItems> {
  // final String Product_Id;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GridTile(
          footer: GridTileBar(
              backgroundColor: Colors.black54,
              //action : IconButton(onPressed: null, icon: Icon(Icons.account_circle_rounded));
              leading: IconButton(
                icon: StreamBuilder<DatabaseEvent>(
                    stream: FirebaseDatabase.instance
                        .ref()
                        .child("FavoriteItems")
                        .child(widget.product.Product_Id)
                        .onValue,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Icon(snapshot.data!.snapshot.exists
                            ? Icons.favorite
                            : Icons.favorite_border_outlined);
                      }
                      return Container();
                    }),
                onPressed: () {
                  print("ON Favorite Pressed");
                  widget.onFavoritePressed();
                },
                color: Colors.red.shade900,
              ),
              title: Center(
                child: Text(
                  widget.product.Product_name,
                  textAlign: TextAlign.center,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () {
                  widget.onShoppingCartButtonPressed();

                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: const Text("Added item to Cart "),
                        duration: const Duration(seconds: 2),
                        action: SnackBarAction(
                            label: "UNDO",
                            onPressed: () async {
                              // final r = await reff
                              //     .child('OrderDetails')
                              //     .child(product.Product_Id)
                              //     .remove();
                              // return r;
                            })),
                  );
                },
                color: Colors.white,
              )),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return EachProductDetails(product: widget.product);
              }));
              // Navigator.of(context).push(MaterialPageRoute(builder: (context){
              //   return EachProductDetails("Product Name");
              //}));
            },
            child: Image.network(
              widget.product.image_url,
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
