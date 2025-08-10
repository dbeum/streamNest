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
        height: 55,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.home_filled),
            title: Text('Home', style: TextStyle(fontSize: 15)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.search),
            title: Text('Search', style: TextStyle(fontSize: 15)),
          ),
          //  FlashyTabBarItem(icon: Icon(Icons.person), title: Text('Profile')),
        ],
      ),
    );
  }
}
