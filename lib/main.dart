import 'package:evyan_emporia_shop_app/Welcome/welcome.dart';
import 'package:evyan_emporia_shop_app/providers/app_states.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/product_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_)=> StateProvider())
    ],
    child: const ShopApp(),
  ));
}

class ShopApp extends StatefulWidget {
  const ShopApp({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _ShopAppState();
}

class _ShopAppState extends State {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white30,
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
      /*routes: {
          UserProductScreen.routeName: (ctx)=> UserProductScreen(Product_name, imageUrl),
        },*/
    );
  }
}
