import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/shayari_model.dart';

class LocalStorageService {
  static const String _shayariKey = 'saved_shayaris';

  // 1. Shayari List Ko Phone Storage Mein Save Karna
  static Future<void> saveShayaris(List<ShayariModel> shayaris) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Model objects ko JSON Map mein convert karna
    List<Map<String, dynamic>> jsonList = shayaris.map((shayari) {
      return {
        'id': shayari.id,
        'text': shayari.text,
        'authorName': shayari.authorName,
        'category': shayari.category,
        'likesCount': shayari.likesCount,
        'isLiked': shayari.isLiked,
      };
    }).toList();

    // String mein convert karke save karna
    String jsonString = jsonEncode(jsonList);
    await prefs.setString(_shayariKey, jsonString);
  }

  // 2. Saved Shayaris Ko Fetch/Load Karna
  static Future<List<ShayariModel>> loadShayaris() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_shayariKey);

    if (jsonString == null || jsonString.isEmpty) {
      return []; // Agar koi data save nahi hai toh empty list
    }

    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) {
      return ShayariModel(
        id: item['id'],
        text: item['text'],
        authorName: item['authorName'],
        category: item['category'],
        likesCount: item['likesCount'],
        isLiked: item['isLiked'],
      );
    }).toList();
  }
}
