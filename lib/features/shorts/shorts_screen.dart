import 'package:flutter/material.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({super.key});

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  final PageController _pageController = PageController();

  // Dummy Short Videos List
  final List<Map<String, String>> _shortsList = [
    {'user': 'user_a', 'caption': 'Amazing sunset view! 🌅 #nature'},
    {'user': 'user_b', 'caption': 'Check out this funny video 😂 #comedy'},
    {'user': 'user_c', 'caption': 'Coding life in 2026 💻 #flutter'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical, // Vertical Swipe for Reels
        controller: _pageController,
        itemCount: _shortsList.length,
        itemBuilder: (context, index) {
          final item = _shortsList[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              // Video Container Placeholder
              Container(
                color: Colors.grey[900],
                child: const Center(
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 80,
                    color: Colors.amber,
                  ),
                ),
              ),

              // Right Side Actions (Like, Comment, Share)
              Positioned(
                right: 16,
                bottom: 100,
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.white, size: 32),
                      onPressed: () {},
                    ),
                    const Text('12.5k', style: TextStyle(color: Colors.white, fontSize: 12)),
                    const SizedBox(height: 16),
                    IconButton(
                      icon: const Icon(Icons.comment, color: Colors.white, size: 32),
                      onPressed: () {},
                    ),
                    const Text('450', style: TextStyle(color: Colors.white, fontSize: 12)),
                    const SizedBox(height: 16),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.amber, size: 32),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // Bottom Video Info & Username
              Positioned(
                left: 16,
                bottom: 40,
                right: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.amber,
                          child: Icon(Icons.person, color: Colors.black, size: 20),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '@${item['user']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['caption']!,
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
