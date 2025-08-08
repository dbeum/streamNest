import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:stream_nest/features/home/view/home_view.dart';
import 'package:stream_nest/features/search/view/search_view.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [Home(), SearchView(), Center(child: Text("2"))];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Center(child: tabItems[_selectedIndex]),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(icon: Icon(Icons.event), title: Text('Home')),
          FlashyTabBarItem(icon: Icon(Icons.search), title: Text('Search')),
          FlashyTabBarItem(icon: Icon(Icons.person), title: Text('Profile')),
        ],
      ),
    );
  }
}
