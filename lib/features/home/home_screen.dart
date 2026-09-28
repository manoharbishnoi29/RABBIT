import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Rabbit 🐇',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.amber,
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'User_${index + 1}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[850],
                    child: const Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text('Sample caption for this post #rabbit', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
