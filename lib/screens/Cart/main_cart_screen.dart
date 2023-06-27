import 'package:evyan_emporia_shop_app/screens/Cart/order_page.dart';
import 'package:evyan_emporia_shop_app/screens/Cart/payment_page.dart';
import 'package:evyan_emporia_shop_app/screens/Cart/shipping_address.dart';
import 'package:flutter/material.dart';

class MainCartScreen extends StatefulWidget {
  const MainCartScreen({Key? key}) : super(key: key);

  @override
  State<MainCartScreen> createState() => _MainCartScreenState();
}

class _MainCartScreenState extends State<MainCartScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool showFab = true;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 3, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      if(_tabController.index==1){
        showFab = true ;
      }
      else{
        showFab = false;
      }
      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: AppBar(
            backgroundColor: Colors.indigo.shade900,
            title: const Text(" Shopping Cart"),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(child: Text( "---Orders---",style: TextStyle(color: Colors.white),),),
                Tab(child: Text("---Delivery---",style: TextStyle(color: Colors.white),),),
                Tab(child: Text("---Payment---", style: TextStyle(color: Colors.white),),)
              ],
            ),
          ),
        ),
        body: FutureBuilder(
          future: Future.delayed(Duration.zero),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  OrderPage(),
                  ShippingPage(),
                  PaymentPage(),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),

      ),
    );
  }
}
