import 'package:flutter/material.dart';
import 'package:yana/pages/explore.dart';
import 'package:yana/pages/home.dart';

class CustomNav extends StatefulWidget {
  const CustomNav({super.key});

  @override
  State<CustomNav> createState() => _CustomNavState();
}

class _CustomNavState extends State<CustomNav> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 1: Saved',
    ),
    ExplorePage(),
    Text(
      'Index 3: Forum',
    ),
    Text(
      'Index 4: Profile',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          label: 'Forum',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      unselectedIconTheme: const IconThemeData(color: Colors.black),
      unselectedLabelStyle: const TextStyle(color: Colors.black),
      selectedItemColor: const Color(0xFF98DAD9),
      onTap: _onItemTapped,
    );
  }
}
