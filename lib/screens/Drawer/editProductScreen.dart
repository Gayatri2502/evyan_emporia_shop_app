import 'package:evyan_emporia_shop_app/providers/server_end_product_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;

  EditProductScreen({Key? key, required this.product}) : super(key: key);

  TextEditingController productIdController = TextEditingController();

  TextEditingController productNameController = TextEditingController();

  TextEditingController productDescriptionController = TextEditingController();

  TextEditingController productPriceController = TextEditingController();

  TextEditingController productImageURLController = TextEditingController();

  void saveForm() {
    Product newProduct = Product(
        Product_Id: productIdController.text,
        Product_name: productNameController.text,
        Product_description: productDescriptionController.text,
        Product_price: double.parse(productPriceController.text),
        image_url: productImageURLController.text);

    FirebaseDatabase.instance
        .ref()
        .child("Product")
        .child(newProduct.Product_Id)
        .set(newProduct.toJson());
  }

  @override
  Widget build(BuildContext context) {
    productIdController.text = product.Product_Id;
    productNameController.text = product.Product_name;
    productDescriptionController.text = product.Product_description;
    productPriceController.text = product.Product_price.toString();
    productImageURLController.text = product.image_url;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Editor Screen",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              controller: productIdController,
              decoration: const InputDecoration(
                  label: Text("Product ID :")),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              controller: productNameController,
              decoration: const InputDecoration(
                  label: Text("Name of Product :")),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: productDescriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: const InputDecoration(
                  label: Text(
                      " Product Description :")),
            ),
            TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: productPriceController,
                decoration: const InputDecoration(
                    label: Text("Price :"))),
            Row(
              children: [
                Expanded(
                    child: StreamBuilder<String>(
                        stream: Stream.periodic(const Duration(milliseconds: 1),
                            (_) {
                          return product.image_url;
                        }),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.isNotEmpty) {
                              return Image.network(snapshot.data!);
                            }

                            return const Text("No Image");
                          }
                          return const Text("No Image");
                        })),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: productImageURLController,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                        label: Text("Image Url : ${product.image_url}")),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(" Edit Product"),
            ),
          ],
        ),
      ),
    );
  }
}
