import 'package:evyan_emporia_shop_app/screens/Drawer/manage_products.dart';
import 'package:evyan_emporia_shop_app/screens/FavoriteItemsGrid.dart';
import 'package:evyan_emporia_shop_app/screens/Profile_Page.dart';
import 'package:flutter/material.dart';


class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: MediaQuery.of(context).size.width*0.5,
        child: Drawer(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.5,
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: const Text(''),
                  accountEmail: const Text(''),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/ImageLists?q=tbn:ANd9GcTTOkHm3_mPQ5PPRvGtU6Si7FJg8DVDtZ47rw&usqp=CAU',
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(fit: BoxFit.fill, image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSilNm5Cr7U-_dTDYKs4ARG3iO1PJcJBO_UMQ&usqp=CAU')),
                  ),
                ),
                ListTile(

                  leading: const Icon(Icons.favorite),
                  title: const Text('Favorites'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_){
                      return const FavGrid();
                    }));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('My Account'),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>  ProfilePage()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.share),
                  title: const Text('Share'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  onTap: (){},
                  trailing: ClipOval(
                    child: Container(
                      color: Colors.red,
                      width: 20,
                      height: 20,
                      child: const Center(
                        child: Text(
                          '8',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () => (){},
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Manage Products'),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return   ManageProducts();
                  })),
                ),
                const Divider(),
                ListTile(
                  title: const Text('LogOut'),
                  leading: const Icon(Icons.exit_to_app),
                  onTap: (){},
                ),
              ],
            ),
          ),
        ),
      );

  }
}
