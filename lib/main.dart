import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rabbit App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    AddPostScreen(),
    ShortsScreen(),
    ShayariScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Shorts'),
          BottomNavigationBarItem(icon: Icon(Icons.format_quote), label: 'Shayari'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Center(child: Text("Home Feed", style: TextStyle(color: Colors.white, fontSize: 20)));
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Center(child: Text("Search Page", style: TextStyle(color: Colors.white, fontSize: 20)));
}

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Center(child: Text("Add Post", style: TextStyle(color: Colors.white, fontSize: 20)));
}

class ShortsScreen extends StatelessWidget {
  const ShortsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Center(child: Text("Shorts Feed", style: TextStyle(color: Colors.white, fontSize: 20)));
}

class ShayariScreen extends StatelessWidget {
  const ShayariScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Center(child: Text("Shayari Section", style: TextStyle(color: Colors.white, fontSize: 20)));
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Center(child: Text("User Profile", style: TextStyle(color: Colors.white, fontSize: 20)));
}
