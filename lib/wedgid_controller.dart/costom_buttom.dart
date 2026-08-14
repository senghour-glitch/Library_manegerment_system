import 'package:flutter/material.dart';
import 'package:library_onlile/view/home_screen.dart';
import 'package:library_onlile/view/mylibrary_screen.dart';
import 'package:library_onlile/view/profile_screen.dart';
import 'package:library_onlile/view/search_screen.dart';

class CustomBottom extends StatefulWidget {
  const CustomBottom({super.key});

  @override
  State<CustomBottom> createState() => _CustomBottomState();
}

class _CustomBottomState extends State<CustomBottom> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    SearchScreen(),
    MylibraryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: Container(
        height: 75,
        decoration: const BoxDecoration(
          color: Color(0xFFF9F9FD),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildItem(
              icon: Icons.home_rounded,
              label: 'Home',
              index: 0,
            ),
            _buildItem(
              icon: Icons.search_rounded,
              label: 'Search',
              index: 1,
            ),
            _buildItem(
              icon: Icons.menu_book_rounded,
              label: 'My Library',
              index: 2,
            ),
            _buildItem(
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool selected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: SizedBox(
        width: 75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: selected ? 56 : 40,
              height: selected ? 40 : 30,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF176581)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: selected
                    ? Colors.white
                    : const Color(0xFF69717D),
                size: 23,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: selected
                    ? const Color(0xFF176581)
                    : const Color(0xFF69717D),
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}