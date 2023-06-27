import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


import '../providers/server_end_product_view.dart';

class CartGridItem extends StatefulWidget {
  final Product product;
  int Quantity;
  Function() onDismissed;


  CartGridItem(
    this.product,
    this.Quantity,

    this.onDismissed, {
    Key? key,
  }) : super(key: key);



  @override
  State<CartGridItem> createState() => _CartGridItemState();
}

class _CartGridItemState extends State<CartGridItem> {
  @override
  final DatabaseReference reff = FirebaseDatabase.instance.ref();


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.product.Product_Id),
      background: Container(
          color: Colors.redAccent.shade700,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          )),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
         widget.onDismissed();
        return null;
      },
      onDismissed: (direction) async {
        // await reff
        //     .child('OrderDetails')
        //     .child(widget.product.Product_Id)
        //     .remove();
        FirebaseDatabase.instance.ref().child('OrderDetails').child(widget.product.Product_Id).remove();
        // Provider.of<CartProvider>(context, listen: false)
        //     .removeSingleItem(product.Product_Id);

      },
      child: Card(
        color: Colors.orange.shade50,
        margin: const EdgeInsets.symmetric(
          horizontal: 1,
          vertical: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              maxRadius: 25,
                backgroundImage:
                NetworkImage(widget.product.image_url)),
            title: Text(widget.product.Product_name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),
            subtitle: Text(
                'Price: \$${(widget.product.Product_price)} \n\n'
                    'Total: \$${(widget.product.Product_price)*(widget.product.quantity)}',style:TextStyle( fontSize: 15, fontWeight: FontWeight.w500)),
            trailing: Text('${widget.product.quantity} X'),
          ),
        ),
      ),
    );
  }
}
