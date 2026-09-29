import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search users or posts...",
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(Icons.search, color: Colors.amber),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[900],
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
          ),
        ),
      ),
      body: const Center(
        child: Text(
          "Type above to search users",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
