import 'package:flutter/material.dart';
import '../../models/shayari_model.dart';
import 'shayari_card_widget.dart';
import 'add_shayari_screen.dart';

class ShayariListScreen extends StatefulWidget {
  const ShayariListScreen({super.key});

  @override
  State<ShayariListScreen> createState() => _ShayariListScreenState();
}

class _ShayariListScreenState extends State<ShayariListScreen> {
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Love',
    'Sad',
    'Attitude',
    'Motivation'
  ];

  // Dummy Shayari Data
  final List<ShayariModel> sampleShayaris = [
    ShayariModel(
      id: '1',
      text: 'Dil se nikli hi nahi baat abhi tak,\nWoh jo thi ek mulaqat abhi tak.',
      authorName: 'Rahul',
      category: 'Love',
      likesCount: 15,
    ),
    ShayariModel(
      id: '2',
      text: 'Manzil unhi ko milti hai jinke sapno mein jaan hoti hai,\nPankh se kuch nahi hota, hoslon se udaan hoti hai.',
      authorName: 'Admin',
      category: 'Motivation',
      likesCount: 42,
    ),
    ShayariModel(
      id: '3',
      text: 'Khamoshi ko samajhna seekho,\nHar shabdh mein wafa nahi hoti.',
      authorName: 'User XYZ',
      category: 'Sad',
      likesCount: 8,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Filter logic based on selected category
    List<ShayariModel> filteredShayaris = selectedCategory == 'All'
        ? sampleShayaris
        : sampleShayaris
            .where((s) => s.category == selectedCategory)
            .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Shayari Feed',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.amber),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddShayariScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter Chips List
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = cat == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: Colors.amber,
                    backgroundColor: Colors.grey[850],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        selectedCategory = cat;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // Shayari Cards List
          Expanded(
            child: ListView.builder(
              itemCount: filteredShayaris.length,
              itemBuilder: (context, index) {
                return ShayariCardWidget(shayari: filteredShayaris[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
