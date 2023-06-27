import 'package:carousel_slider/carousel_slider.dart';
import 'package:evyan_emporia_shop_app/Carousel_Slider/brands%20data.dart';
import 'package:evyan_emporia_shop_app/Carousel_Slider/descriptive_products.dart';
import 'package:evyan_emporia_shop_app/Carousel_Slider/offer%20data.dart';
import 'package:evyan_emporia_shop_app/screens/Cart/main_cart_screen.dart';
import 'package:evyan_emporia_shop_app/screens/FavoriteItemsGrid.dart';
import 'package:evyan_emporia_shop_app/screens/Profile_Page.dart';
import 'package:evyan_emporia_shop_app/widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'Cart/order_page.dart';
import 'Drawer/sideBar.dart';

import '../Carousel_Slider/category data.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            iconSize: 40,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const NavBar();
              }));
            },
          ),

          title: const Text("Evyan Emporia"),
          actions: [
            IconButton(onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return ProfilePage();
              }));
            }, icon: const Icon(Icons.person)),
            IconButton(onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return const MainCartScreen();
              }));
            }, icon: const Icon(Icons.shopping_cart)),
            PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (_) => [
                      PopupMenuItem(
                        value: 1,
                        onTap: () {},
                        child: Row(
                          children: const [
                            Icon(
                              Icons.settings,
                              color: Colors.black,
                            ),
                            Text('Settings',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.favorite,
                              color: Colors.black,
                            ),
                            Text(
                              'Wish List',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const FavGrid();
                          }));
                        },
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.add_shopping_cart_sharp,
                              color: Colors.black,
                            ),
                            Text('Your Orders',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const OrderPage();
                          }));
                        },
                      ),
                      PopupMenuItem(
                        value: 4,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.manage_history_sharp,
                              color: Colors.black,
                            ),
                            Text('Manage Account',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 5,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.quick_contacts_dialer,
                              color: Colors.black,
                            ),
                            Text('Contact Us',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 6,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.logout,
                              color: Colors.black,
                            ),
                            Text('LogOut',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      )
                    ]),
          ],
          backgroundColor: Colors.indigo.shade900,
        ),
        body: SizedBox(

          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              const SizedBox(
                height: 20,
              ),
              CarouselSlider(
                items: [
                  ...offerList.map(
                    (e) => Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(e.offerUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
                ],

                //Slider Container properties
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: false,
                  autoPlay: false,
                  aspectRatio: 16 / 10,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration:
                      const Duration(milliseconds: 600),
                  viewportFraction: 0.8,
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.black87,
                padding: const EdgeInsets.all(8.0),
                child: CarouselSlider(
                  items: [
                    ...categoryList.map(
                          (e) => Container(
                        margin: const EdgeInsets.all(0.0),
                        decoration: ShapeDecoration(
                          // borderRadius: BorderRadius.circular(250.0),
                            image: DecorationImage(
                              image: NetworkImage(e.catUrl),
                              fit: BoxFit.fitHeight,
                            ),
                            shape: const CircleBorder()),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 55.0,
                    enlargeCenterPage: false,
                    autoPlay: false,
                    aspectRatio: 16 / 18,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                    const Duration(milliseconds: 600),
                    viewportFraction: 0.2,
                  ),
                ),
              ),
              Container(
                color: Colors.cyan,
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      " ▁ ▂ ▃ ▅ ▆ ▇ █ Shop by BRAND █ ▇ ▆ ▅ ▃ ▂ ▁",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
              ),
              CarouselSlider(
                items: [
                  ...imgList.map(
                    (e) => Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(e.imgUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ],

                //Slider Container properties
                options: CarouselOptions(
                  height: 100.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration:
                      const Duration(milliseconds: 600),
                  viewportFraction: 0.55,
                ),
              ),
              Container(
                color: Colors.indigo,
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 18,
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      '....△ 𝙲𝚘𝚗𝚝𝚒𝚗𝚞𝚎 𝚋𝚛𝚘𝚠𝚜𝚒𝚗𝚐 𝚝𝚑𝚎𝚜𝚎 𝚋𝚛𝚊𝚗𝚍𝚜 ▼....',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.black54,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 300,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.4,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: false,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: [
                    ...desProductList.map(
                      (e) => Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child:
                                  Image.network(e.imageurl, fit: BoxFit.fill),
                            ),
                            Text(
                              e.name,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              e.description,
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              e.price,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Container(
                color: Colors.deepOrange,
                height: 150,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5R1Bj_lLTTUS9NtmSQTjOjpRKNN_Lcq-9eA&usqp=CAU",
                    fit: BoxFit.fill),
              ),
              const Expanded(child: ProductGrid()),

            ],
          ),
        ));
  }
}
