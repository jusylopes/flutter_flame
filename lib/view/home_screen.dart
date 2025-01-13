import 'package:flutter/material.dart';
import 'package:flutter_flame/core/utils/app_strings.dart';
import 'package:flutter_flame/core/widgets/animated_cloud_background.dart';
import 'package:flutter_flame/core/widgets/tab_bar_item.dart';
import 'package:flutter_flame/view/contact_screen.dart';
import 'package:flutter_flame/view/fire_screen.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    FireScreen(),
    ContactScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          const AnimatedCloudBackground(),
          Center(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 64,
          vertical: 16,
        ),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabBarItem(
                icon: Iconsax.home,
                label: AppStrings.itemBottomNavigationBarHome,
                index: 0,
                isSelected: _selectedIndex == 0,
                onItemTapped: _onItemTapped,
              ),
              TabBarItem(
                icon: Iconsax.book,
                label: AppStrings.itemBottomNavigationBarContact,
                index: 1,
                isSelected: _selectedIndex == 1,
                onItemTapped: _onItemTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
