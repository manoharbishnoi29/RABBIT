import 'package:flutter/material.dart';
import 'features/home/home_screen.dart';
import 'features/search/search_screen.dart';
import 'features/add_post/add_post_screen.dart';
import 'features/shorts/shorts_screen.dart';
import 'features/shayari/shayari_list_screen.dart';
import 'features/profile/profile_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  // App Ki Saari Screens Ki List
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const AddPostScreen(),
    const ShortsScreen(),
    const ShayariListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Add Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection_outlined),
            label: 'Shorts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Shayari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
