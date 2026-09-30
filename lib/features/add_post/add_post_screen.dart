import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String? _selectedFileName;
  final TextEditingController _captionController = TextEditingController();
  bool isUploading = false;

  Future<void> _pickFile(FileType type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: type);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFileName = result.files.first.name;
      });
    }
  }

  Future<void> _sharePost() async {
    final caption = _captionController.text.trim();
    if (_selectedFileName == null && caption.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Kuch caption ya file select karein!")));
      return;
    }

    setState(() => isUploading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      final username = userDoc.data()?['username'] ?? 'User';

      await FirebaseFirestore.instance.collection('posts').add({
        'uid': user.uid,
        'username': username,
        'caption': caption,
        'fileName': _selectedFileName ?? '',
        'createdAt': FieldValue.serverTimestamp(),
        'likes': 0,
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Post Successfully Uploaded!")));
      setState(() {
        _selectedFileName = null;
        _captionController.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) setState(() => isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Create New Post", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.amber),
              ),
              child: _selectedFileName != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle, size: 50, color: Colors.amber),
                        const SizedBox(height: 10),
                        Text(_selectedFileName!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        TextButton(onPressed: () => setState(() => _selectedFileName = null), child: const Text("Remove", style: TextStyle(color: Colors.red))),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_a_photo, size: 40, color: Colors.amber),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                              onPressed: () => _pickFile(FileType.image),
                              icon: const Icon(Icons.image, color: Colors.black),
                              label: const Text("Photo", style: TextStyle(color: Colors.black)),
                            ),
                            const SizedBox(width: 15),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                              onPressed: () => _pickFile(FileType.video),
                              icon: const Icon(Icons.videocam, color: Colors.black),
                              label: const Text("Video", style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _captionController,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Write a caption...",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 25),
            isUploading
                ? const CircularProgressIndicator(color: Colors.amber)
                : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                      onPressed: _sharePost,
                      child: const Text("Share Post", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
