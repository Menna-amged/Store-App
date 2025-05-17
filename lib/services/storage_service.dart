import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static const String _emailsKey = 'registered_emails';

  // Save emails to storage
  static Future<void> saveEmails(List<String> emails) async {
    final prefs = await SharedPreferences.getInstance();
    final String emailsJson = json.encode(emails);
    await prefs.setString(_emailsKey, emailsJson);
  }

  // Load emails from storage
  static Future<List<String>> loadEmails() async {
    final prefs = await SharedPreferences.getInstance();
    final String? emailsJson = prefs.getString(_emailsKey);
    if (emailsJson != null) {
      final List<dynamic> decoded = json.decode(emailsJson);
      return decoded.cast<String>();
    }
    return [];
  }
} 