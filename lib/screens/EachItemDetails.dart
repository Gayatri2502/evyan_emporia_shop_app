import 'package:flutter/material.dart';

import '../providers/server_end_product_view.dart';

class EachProductDetails extends StatelessWidget {
  final Product product;

  //EachProductDetails( this.product);
  const EachProductDetails({Key? key, required this.product}) : super(key: key);

  //ProductDetails(this.product_name);
  @override
  Widget build(BuildContext context) {
    //final ProductName = ModalRoute.of(context)!.settings.arguments as String;

    /*Product Loaded_Products =
        Provider.of<ProductProvider>(context).findById(product.Product_name)!;*/

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(product.Product_name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.image_url,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              " \$${product.Product_price}",
              style: TextStyle(color: Colors.black, fontSize: 34),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.Product_description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
