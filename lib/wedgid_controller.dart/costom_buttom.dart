import 'package:flutter/material.dart';

import 'package:library_onlile/view/home_screen.dart';
import 'package:library_onlile/view/categories_screen.dart';
import 'package:library_onlile/view/mylibrary_screen.dart';
import 'package:library_onlile/view/profile_screen.dart';
import 'package:library_onlile/view/search_screen.dart';

class CostomButtom extends StatefulWidget {
  const CostomButtom({super.key});

  @override
  State<CostomButtom> createState() => _CostomButtomState();
}

class _CostomButtomState extends State<CostomButtom> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: const Color(0xFF16414B),

        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category),
            label: 'Categories',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search ',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
