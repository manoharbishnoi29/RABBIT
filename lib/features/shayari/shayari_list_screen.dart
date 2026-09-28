import 'package:flutter/material.dart';
import '../../models/shayari_model.dart';
import '../../services/local_storage_service.dart';
import 'shayari_card_widget.dart';
import 'add_shayari_screen.dart';

class ShayariListScreen extends StatefulWidget {
  const ShayariListScreen({super.key});

  @override
  State<ShayariListScreen> createState() => _ShayariListScreenState();
}

class _ShayariListScreenState extends State<ShayariListScreen> {
  String selectedCategory = 'All';
  List<ShayariModel> allShayaris = [];
  bool isLoading = true;

  final List<String> categories = ['All', 'Love', 'Sad', 'Attitude', 'Motivation'];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  // App open hote hi storage se data load hoga
  Future<void> _loadSavedData() async {
    List<ShayariModel> savedList = await LocalStorageService.loadShayaris();
    
    setState(() {
      if (savedList.isNotEmpty) {
        allShayaris = savedList;
      } else {
        // First time ke liye default demo data
        allShayaris = [
          ShayariModel(
            id: '1',
            text: 'Dil se nikli hi nahi baat abhi tak,\nWoh jo thi ek mulaqat abhi tak.',
            authorName: 'Rahul',
            category: 'Love',
            likesCount: 15,
          ),
          ShayariModel(
            id: '2',
            text: 'Manzil unhi ko milti hai jinke sapno mein jaan hoti hai.',
            authorName: 'Admin',
            category: 'Motivation',
            likesCount: 42,
          ),
        ];
        // Demo data ko bhi save kar lo
        LocalStorageService.saveShayaris(allShayaris);
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ShayariModel> filteredShayaris = selectedCategory == 'All'
        ? allShayaris
        : allShayaris.where((s) => s.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Shayari Feed', style: TextStyle(color: Colors.amber)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.amber),
            onPressed: () async {
              // Nayi shayari create hone ke baad list ko refresh karna
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddShayariScreen()),
              );
              _loadSavedData(); // Save hua naya data load karega
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.amber))
          : Column(
              children: [
                // Category Chips
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: cat == selectedCategory,
                          selectedColor: Colors.amber,
                          onSelected: (selected) {
                            setState(() {
                              selectedCategory = cat;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                // Shayari List
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
