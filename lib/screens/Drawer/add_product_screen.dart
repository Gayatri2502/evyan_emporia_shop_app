import 'package:evyan_emporia_shop_app/providers/app_states.dart';
import 'package:evyan_emporia_shop_app/providers/server_end_product_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddProductScreen extends StatefulWidget {
  const AddProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {



  @override
  Widget build(BuildContext context) {

    final StateObject1 = Provider.of<StateProvider>(context);
    // final LoadingObject = Provider.of<Product>(context);

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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Add Product Screen",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
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
              decoration: const InputDecoration(label: Text("Product ID :")),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              controller: productNameController,
              decoration:
              const InputDecoration(label: Text("Name of Product :")),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              controller: productDescriptionController,
              decoration:
              const InputDecoration(label: Text(" Product Description :")),
            ),
            TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: productPriceController,
                decoration: const InputDecoration(label: Text("Price :"))),
            Row(
              children: [
                Expanded(
                    child: StreamBuilder<String>(
                        stream: Stream.periodic(const Duration(milliseconds: 1),
                                (_) {
                              return productImageURLController.text;
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
                    keyboardType: TextInputType.url,
                    controller: productImageURLController,
                    decoration:
                    const InputDecoration(label: Text("Image Url :")),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                saveForm();

                setState(() {
                  StateObject1.isLoading = true ;
                });


                Future.delayed(const Duration(seconds:6), (){
                  setState(() {
                    StateObject1.isLoading = false;
                  });
                });
                Navigator.of(context).pop();

              },

              child: const Text(" Add Product"),
            ),

          ],

        ),
      ),
    );
  }
}
