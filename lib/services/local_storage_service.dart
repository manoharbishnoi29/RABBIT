import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/shayari_model.dart';

class LocalStorageService {
  static const String _shayariKey = 'saved_shayaris';
  static const String _usernameKey = 'saved_username';
  static const String _passwordKey = 'saved_password';

  // ==================== SHAYARI STORAGE ====================

  // 1. Shayari List Ko Phone Storage Mein Save Karna
  static Future<void> saveShayaris(List<ShayariModel> shayaris) async {
    final prefs = await SharedPreferences.getInstance();
    
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

    String jsonString = jsonEncode(jsonList);
    await prefs.setString(_shayariKey, jsonString);
  }

  // 2. Saved Shayaris Ko Fetch/Load Karna
  static Future<List<ShayariModel>> loadShayaris() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_shayariKey);

    if (jsonString == null || jsonString.isEmpty) {
      return [];
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

  // ==================== USER AUTH STORAGE ====================

  // 3. User Credentials (Username & Password) Save Karna
  static Future<void> saveUserCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_passwordKey, password);
  }

  // 4. Saved Username Fetch Karna
  static Future<String?> getSavedUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  // 5. Saved Password Fetch Karna
  static Future<String?> getSavedPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_passwordKey);
  }

  // 6. User Credentials Clear/Logout Karna
  static Future<void> clearUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
    await prefs.remove(_passwordKey);
  }
}
