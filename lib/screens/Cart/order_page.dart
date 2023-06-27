import 'dart:convert';

import 'package:evyan_emporia_shop_app/providers/server_end_product_view.dart';
import 'package:evyan_emporia_shop_app/screens/Cart/shipping_address.dart';
import 'package:evyan_emporia_shop_app/widgets/cart_grid.dart';
import 'package:provider/provider.dart';


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../providers/product_provider.dart';


class OrderPage extends StatefulWidget {
  const OrderPage({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  DatabaseReference refference = FirebaseDatabase.instance.ref();

  onYesClickListener(Product product) {
    return Provider.of<ProductProvider>(context, listen: false)
        .removeSingleProductFromCart(product);
  }

 // late TabController _tabController;


  @override
  Widget build(BuildContext context) {
    List<Product> mapItems = [];

    return  SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.91,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Card(
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: StreamBuilder<DatabaseEvent>(
                          stream: FirebaseDatabase.instance
                              .ref()
                              .child('OrderDetails')
                              .onValue,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Product> CartItems = [];
                              CartItems = snapshot
                                  .data!.snapshot.children
                                  .map((e) => Product.fromJson(
                                  jsonDecode(jsonEncode(e.value))))
                                  .toList();
                              mapItems = CartItems;

                              return ListView.builder(
                                itemBuilder: (BuildContext context, i) {
                                  if (CartItems.isNotEmpty) {
                                    return CartGridItem(CartItems[i], 1,
                                            () {
                                          showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: const Text(
                                                    "Are you Sure ? "),
                                                content: const Text(
                                                    'Do you Want to remove the item from the cart ? '),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    child: const Text(
                                                        'No'),
                                                    onPressed: () {
                                                      Navigator.of(
                                                          context)
                                                          .pop();
                                                    },
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        onYesClickListener(mapItems[i]);
                                                        Navigator.of(
                                                            context)
                                                            .pop();
                                                        // var remove = Provider.of<ProductProvider>(context).removeSingleProductFromCart(mapItems[i]);
                                                      },
                                                      child: const Text(
                                                          'Yes'))
                                                ],
                                              ));
                                        });
                                  }
                                  return Container();
                                },
                                itemCount: CartItems.length,
                              );
                            }
                            return Container();
                          })),
                  Column(
                    children: [

                      Row(

                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text("Total Amount :  ",
                                style: TextStyle(
                                  //color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900)),
                          ),
                          Chip(
                            label: StreamBuilder<double>(
                                stream: Stream.periodic(
                                    const Duration(milliseconds: 1),
                                        (_) {
                                      return mapItems.isNotEmpty
                                          ? mapItems
                                          .map((e) => (e.Product_price *
                                          e.quantity))
                                          .toList()
                                          .reduce((value, element) =>
                                      value + element)
                                          : 0;
                                    }),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      '\$${snapshot.data!.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    );
                                  }
                                  return Container();
                                }),
                            backgroundColor: Colors.blue.shade800,
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(
                                Colors.teal.shade900),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(20)),
                            textStyle:
                            MaterialStateProperty.all(
                                const TextStyle(
                                    fontSize: 18,
                                    fontWeight:
                                    FontWeight.w700,
                                    color: Colors.white))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_){
                            return ShippingPage();
                          }));
                        },
                        child: const Text("PLACE YOUR ORDER"),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
