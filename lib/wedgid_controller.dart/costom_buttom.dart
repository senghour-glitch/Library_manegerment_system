import 'package:flutter/material.dart';

import 'package:library_onlile/view/home_screen.dart';
import 'package:library_onlile/view/search_screen.dart';
import 'package:library_onlile/view/mylibrary_screen.dart';
import 'package:library_onlile/view/profile_screen.dart';


class CostomBottom extends StatefulWidget {
  const CostomBottom({super.key});
  @override
  State<CostomBottom> createState() => _CostomBottomState();
}
class _CostomBottomState extends State<CostomBottom> {
  int selectedIndex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const MylibraryScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });

        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: "My Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}