import 'dart:convert';

import 'package:evyan_emporia_shop_app/screens/Drawer/add_product_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_states.dart';
import '../../providers/server_end_product_view.dart';
import 'editProductScreen.dart';


class ManageProducts extends StatefulWidget {
  const ManageProducts({Key? key}) : super(key: key);

  @override
  State<ManageProducts> createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  // To read or write the data from database we need to Create an instance of Database Reference

  DatabaseReference refference = FirebaseDatabase.instance.ref();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final StateObject = Provider.of<StateProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Products',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const AddProductScreen();
                }));
              },
              icon: const Icon(Icons.add) // It will take to Add product Screen

              )
        ],
        backgroundColor: Colors.black,
      ),
      body: StateObject.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<DatabaseEvent>(
                  stream:
                      FirebaseDatabase.instance.ref().child('Product').onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Product> allProducts =  snapshot
                          .data!.snapshot.children
                          .map((e) =>
                              Product.fromJson(jsonDecode(jsonEncode(e.value))))
                          .toList();
                      print("Snapshot Children Length: ${allProducts.length}");
                      return ListView.separated(
                        itemCount: allProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          Product product = allProducts[index];
                          return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              onDismissed: (_) {},
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: ClipOval(
                                    child: Image.network(product.image_url),
                                  ),
                                ),
                                title: Text(
                                  product.Product_name,
                                ), // take data from Firebase
                                subtitle:
                                    Text(product.Product_price.toString()),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          print(
                                              "Product ID: ${product.Product_Id}");
                                          return EditProductScreen(
                                              product: product);
                                        }));
                                      },
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        StateObject.removeProductFromList();
                                      },
                                      icon: const Icon(Icons.delete),
                                    )
                                  ],
                                ),
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      );
                    }
                    return Container();
                  }),
            ),
    );
  }
}
