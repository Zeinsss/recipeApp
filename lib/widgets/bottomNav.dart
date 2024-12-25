import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.index,
    required this.onTap,
  });

  final int index;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onTap, // Add the callback here
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF7FB069),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.scale),
          label: 'Scale Recipe',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Recipe List',
        ),
      ],
    );
  }
}