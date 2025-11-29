import 'package:flutter/material.dart';
import 'package:foodapp/app/modules/bottomnavgationbar/views/bottomnavgationbar_view.dart';
import 'package:foodapp/app/modules/chatbotpage/views/chatbotpage_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/helpsupportpage_controller.dart';

class HelpsupportpageView extends GetView<HelpsupportpageController> {
  const HelpsupportpageView({super.key});

  // 🔹 Call function
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      Get.snackbar("Error", "Could not launch phone dialer");
    }
  }

  // 🔹 Email function
  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      Get.snackbar("Error", "Could not open email app");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final RxInt expandedIndex = (-1).obs;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.015,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Back Button Row (AppBar illa)
              Positioned(
                top: 16,
                left: 16,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color.fromARGB(255, 248, 211, 99)
                            : Colors.pink, // ✅ fixed
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.09),

              // 🔹 Categories
              SizedBox(
                height: height * 0.16,
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: width * 0.04,
                  mainAxisSpacing: height * 0.01,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildCategory(Icons.fastfood, "Orders", isDark, width),
                    _buildCategory(Icons.payment, "Payments", isDark, width),
                    _buildCategory(Icons.person, "Account", isDark, width),
                    _buildCategory(Icons.money, "Refunds", isDark, width),
                  ],
                ),
              ),
             
              // 🔹 FAQs Title
              Text(
                "Frequently Asked Questions",
                style: GoogleFonts.poppins(
                  fontSize: width * 0.032,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: height * 0.01),

              // 🔹 FAQs Accordion
              Expanded(
                child: Obx(() {
                  if (controller.filteredFaqs.isEmpty) {
                    return Center(
                      child: Text(
                        "No results found",
                        style: GoogleFonts.poppins(
                          fontSize: width * 0.033,
                          color: isDark ? Colors.white70 : Colors.grey,
                        ),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: ExpansionPanelList(
                      dividerColor: Colors.transparent,
                      elevation: 1,
                      expandedHeaderPadding: EdgeInsets.zero,
                      expansionCallback: (panelIndex, isExpanded) {
                        expandedIndex.value = expandedIndex.value == panelIndex
                            ? -1
                            : panelIndex;
                      },
                      children: controller.filteredFaqs
                          .asMap()
                          .entries
                          .map(
                            (entry) => ExpansionPanel(
                              backgroundColor: isDark
                                  ? const Color(0xFF1C1C1C)
                                  : Colors.white,
                              isExpanded: expandedIndex.value == entry.key,
                              canTapOnHeader: true,
                              headerBuilder: (context, isOpen) {
                                return ListTile(
                                  leading: Icon(
                                    Icons.help_outline,
                                    size: width * 0.065,
                                    color: isDark
                                        ? const Color.fromARGB(255, 243, 204, 88)
                                        : Colors.pinkAccent,
                                  ),
                                  title: Text(
                                    entry.value["question"]!,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: width * 0.030,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              },
                              body: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(width * 0.04),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: isDark
                                          ? Colors.grey.shade800
                                          : Colors.grey.shade300,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  entry.value["answer"]!,
                                  style: GoogleFonts.poppins(
                                    fontSize: width * 0.032,
                                    height: 1.4,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.grey[700],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                }),
              ),

              SizedBox(height: height * 0.025),

              // 🔹 Contact Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _makePhoneCall("9876543210"),
                    child: _buildContactButton(
                      Icons.call,
                      "Call Us",
                      isDark,
                      width,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _sendEmail("support@example.com"),
                    child: _buildContactButton(
                      Icons.email,
                      "Email Us",
                      isDark,
                      width,
                    ),
                  ),
                   GestureDetector(
                    onTap: () => Get.to(()),
                    child: _buildContactButton(
                      Icons.chat,
                      "Chatbot",
                      isDark,
                      width,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.025),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Category Widget
  Widget _buildCategory(
    IconData icon,
    String label,
    bool isDark,
    double width,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: width * 0.05,
          backgroundColor: isDark ? const Color.fromARGB(255, 243, 204, 88): Colors.pinkAccent,
          child: Icon(icon, color: Colors.white, size: width * 0.065),
        ),
        SizedBox(height: width * 0.018),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: width * 0.027,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // 🔹 Contact Button Widget
  Widget _buildContactButton(
    IconData icon,
    String label,
    bool isDark,
    double width,
  ) {
    return Column(
      children: [
        CircleAvatar(
          radius: width * 0.054,
          backgroundColor: isDark ? const Color.fromARGB(255, 243, 204, 88) : Colors.pinkAccent,
          child: Icon(icon, color: Colors.white, size: width * 0.06),
        ),
        SizedBox(height: width * 0.018),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: width * 0.028,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
