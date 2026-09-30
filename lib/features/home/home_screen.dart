import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Rabbit 🐇", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.amber));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Posts Yet", style: TextStyle(color: Colors.grey)));
          }

          final posts = snapshot.data!.docs;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index].data() as Map<String, dynamic>;
              return Card(
                color: Colors.grey[900],
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.person, color: Colors.black)),
                          const SizedBox(width: 10),
                          Text(post['username'] ?? 'User', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (post['caption'] != null && post['caption'].toString().isNotEmpty)
                        Text(post['caption'], style: const TextStyle(color: Colors.white, fontSize: 16)),
                      if (post['fileName'] != null && post['fileName'].toString().isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              const Icon(Icons.attach_file, color: Colors.amber),
                              const SizedBox(width: 5),
                              Expanded(child: Text(post['fileName'], style: const TextStyle(color: Colors.grey))),
                            ],
                          ),
                        )
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
