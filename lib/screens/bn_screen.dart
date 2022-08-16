import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_udeny/models/bn_screen_item.dart';
import 'package:shop_udeny/screens/category_screen.dart';
import 'package:shop_udeny/screens/favorite_screen.dart';
import 'package:shop_udeny/screens/home_screen.dart';
import 'package:shop_udeny/screens/settings_screen.dart';


class BnScreen extends StatefulWidget {
  const BnScreen({Key? key}) : super(key: key);

  @override
  State<BnScreen> createState() => _BnScreenState();
}

class _BnScreenState extends State<BnScreen> {
  int _currentIndex = 0;
  final List<BnItem> _bnScreens = <BnItem>[
     BnItem(widget: Homescreen(), title: 'Home' ),
     BnItem(widget: CategoryScreen(), title: 'Categories'),
     BnItem(widget: Favoritescreen(), title: 'Profile'),
     BnItem(widget: Settingscreen(), title: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          _bnScreens[_currentIndex].title,

          style: GoogleFonts.nunito(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
            Icon(Icons.search),

        ],

      ),
      body: _bnScreens[_currentIndex].widget,


      bottomNavigationBar: BottomNavigationBar(
        onTap: (int itemIndex) {
          setState(() {
            _currentIndex = itemIndex;
          });
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.black26,
        items: const [
          BottomNavigationBarItem(
              backgroundColor: Colors.pink,
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(Icons.apps_outlined),
              activeIcon: Icon(Icons.apps),
              label: 'Categories'),
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.favorite_outlined),
              activeIcon: Icon(Icons.favorite),
              label: 'Favorite'),
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: 'Settings'),
        ],
      ),
    );
  }


}
