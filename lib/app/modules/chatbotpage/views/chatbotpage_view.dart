
import 'package:flutter/material.dart';
import 'package:foodapp/app/modules/bottomnavgationbar/views/bottomnavgationbar_view.dart';
import 'package:foodapp/app/modules/chatbotpage/controllers/chatbotpage_controller.dart';
import 'package:get/get.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatbotView extends GetView<ChatbotpageController> {
  const ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatbotpageController());
    final isDark = Get.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: isDark
            ? const Color.fromARGB(255, 249, 211, 95)
            : Colors.pink,
        elevation: 3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.to(BottomnavigationbarView()),
        ),
        title: Text(
          "Neztora AI",
          style: GoogleFonts.poppins(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Add future settings or options here
            },
          ),
        ],
      ),
      body: GetBuilder<ChatbotpageController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: DashChat(
              currentUser: controller.myself,
              messages: controller.allMessages,
              onSend: (ChatMessage message) {
                controller.getData(message);
              },
              typingUsers: controller.typing,
              messageOptions: MessageOptions(
                showOtherUsersName: true,
                showTime: true,
                currentUserTextColor: isDark ? Colors.white : Colors.black,
                containerColor: isDark
                    ? const Color.fromARGB(255, 216, 216, 214)
                    : Colors.white,
                currentUserContainerColor: isDark
                    ? Colors.teal[700]!
                    : const Color(0xFFDCF8C6),
                borderRadius: 20,
              ),
              inputOptions: InputOptions(
                inputDecoration: InputDecoration(
                  hintText: "Type your message...",
                  hintStyle: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                  fillColor: isDark ? Colors.grey[850] : Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: isDark ? Colors.grey : Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: isDark ? Colors.tealAccent : Colors.blueAccent,
                    ),
                  ),
                ),
                cursorStyle: CursorStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
                sendButtonBuilder: (send) => Container(
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.teal
                        : const Color.fromARGB(255, 248, 233, 101),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: send,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
