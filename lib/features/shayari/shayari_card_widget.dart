import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/shayari_model.dart';

class ShayariCardWidget extends StatefulWidget {
  final ShayariModel shayari;

  const ShayariCardWidget({super.key, required this.shayari});

  @override
  State<ShayariCardWidget> createState() => _ShayariCardWidgetState();
}

class _ShayariCardWidgetState extends State<ShayariCardWidget> {
  void _toggleLike() {
    setState(() {
      widget.shayari.isLiked = !widget.shayari.isLiked;
      if (widget.shayari.isLiked) {
        widget.shayari.likesCount++;
      } else {
        widget.shayari.likesCount--;
      }
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.shayari.text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Shayari copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.amber, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Badge & Author
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.shayari.category,
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  backgroundColor: Colors.amber,
                  padding: EdgeInsets.zero,
                ),
                Text(
                  '- ${widget.shayari.authorName}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Shayari Text Content
            Text(
              widget.shayari.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),

            // Action Buttons: Like, Copy, Share
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Like Button & Count
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        widget.shayari.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.shayari.isLiked ? Colors.red : Colors.grey,
                      ),
                      onPressed: _toggleLike,
                    ),
                    Text(
                      '${widget.shayari.likesCount}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),

                // Copy & Share Buttons
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.grey),
                      onPressed: _copyToClipboard,
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.amber),
                      onPressed: () {
                        // Share logic will go here
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
