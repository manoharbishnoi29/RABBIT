import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String? _selectedFileName;
  final TextEditingController _captionController = TextEditingController();

  // Mobile Gallery / Browser File Picker Function
  Future<void> _pickFile(FileType type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: type);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFileName = result.files.first.name;
      });
    }
  }

  void _sharePost() {
    if (_selectedFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kripya pehle photo ya video gallery se select karein!")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Post Successfully Uploaded!")),
    );

    setState(() {
      _selectedFileName = null;
      _captionController.clear();
    });
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
              height: 250,
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
                        const Icon(Icons.check_circle, size: 60, color: Colors.amber),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            _selectedFileName!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          onPressed: () => setState(() => _selectedFileName = null),
                          child: const Text("Remove", style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_a_photo, size: 50, color: Colors.amber),
                        const SizedBox(height: 10),
                        const Text("Open Gallery to Pick File", style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 15),
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
            SizedBox(
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
