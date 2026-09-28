import 'package:flutter/material.dart';

class AddShayariScreen extends StatefulWidget {
  const AddShayariScreen({super.key});

  @override
  State<AddShayariScreen> createState() => _AddShayariScreenState();
}

class _AddShayariScreenState extends State<AddShayariScreen> {
  final TextEditingController _shayariController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  String selectedCategory = 'Love';
  final List<String> categories = ['Love', 'Sad', 'Attitude', 'Motivation'];

  void _submitShayari() {
    if (_shayariController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter some shayari!')),
      );
      return;
    }

    // Logic to save/upload Shayari can be added here

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Shayari posted successfully!')),
    );

    Navigator.pop(context); // Go back to Shayari list screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Post New Shayari',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Writer/Author Name Field
              TextField(
                controller: _authorController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Your Name / Writer Name',
                  labelStyle: const TextStyle(color: Colors.amber),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Category Selector Dropdown
              const Text(
                'Select Category:',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[800]!),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    dropdownColor: Colors.grey[900],
                    isExpanded: true,
                    style: const TextStyle(color: Colors.amber, fontSize: 16),
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedCategory = newValue;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Shayari Content Input Box
              TextField(
                controller: _shayariController,
                maxLines: 5,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Type your shayari here...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitShayari,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Publish Shayari',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
