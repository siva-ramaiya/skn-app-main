import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:intl/intl.dart';

class ChatbotpageController extends GetxController {
  final DateTime nowInIST = DateTime.now().toUtc().add(const Duration(hours: 5, minutes: 30));
  
  final ChatUser myself = ChatUser(id: '1', firstName: 'Tom');
  final ChatUser bot = ChatUser(id: '2', firstName: 'Gemini');

  final RxList<ChatMessage> allMessages = <ChatMessage>[].obs;
  final RxList<ChatUser> typing = <ChatUser>[].obs;

  final String apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyDP44VfvPWKWEvakEN222NJvyUnPqHz6TU';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  Future<void> getData(ChatMessage message) async {
    typing.add(bot);          // Show typing
    allMessages.insert(0, message); // Add user message

    final Map<String, dynamic> data = {
      "contents": [
        {
          "parts": [
            {"text": message.text}
          ]
        }
      ]
    };

    try {
      print('Sending request to API...');
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(data),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final String botReply = result['candidates'][0]['content']['parts'][0]['text'];

        final ChatMessage botMessage = ChatMessage(
          text: botReply,
          user: bot,
          createdAt: nowInIST,
        );

        allMessages.insert(0, botMessage);
      } else if (response.statusCode == 429) {
        // Handle rate limit gracefully
        final ChatMessage botMessage = ChatMessage(
          text:
              "⚠️ Too many requests. Please wait a few seconds and try again.",
          user: bot,
          createdAt: nowInIST,
        );
        allMessages.insert(0, botMessage);
      } else {
        final ChatMessage botMessage = ChatMessage(
          text: "⚠️ Error: ${response.statusCode}",
          user: bot,
          createdAt: nowInIST,
        );
        allMessages.insert(0, botMessage);
      }
    } catch (e) {
      final ChatMessage botMessage = ChatMessage(
        text: "⚠️ Exception occurred: $e",
        user: bot,
        createdAt: nowInIST,
      );
      allMessages.insert(0, botMessage);
    } finally {
      typing.remove(bot); // Remove typing
      print('Request completed.');
      update();
    }
  }
}
