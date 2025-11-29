import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpsupportpageController extends GetxController {
  /// Full FAQ source
  final List<Map<String, String>> allFaqs = [
    {
      "question": "How do I track my order?",
      "answer": "Go to Orders → select the order → tap Track to see live status.",
    },
    {
      "question": "I was charged but my order failed. What should I do?",
      "answer":
          "Failed orders are auto-refunded within 3–5 business days. If not, contact support with the transaction ID.",
    },
    {
      "question": "How do I update my delivery address?",
      "answer":
          "Profile → Addresses → Add or Edit address. For active orders, contact support to update.",
    },
    {
      "question": "When will I receive my refund?",
      "answer":
          "Once approved, refunds typically take 3–7 business days depending on your bank.",
    },
    {
      "question": "How can I change my account password?",
      "answer":
          "Profile → Security → Change Password. You’ll need your current password or OTP.",
    },
    {
      "question": "Can I cancel my order after placing it?",
      "answer":
          "You can cancel before the restaurant starts preparing. Go to Orders → Order Details → Cancel.",
    },
    {
      "question": "What payment methods do you accept?",
      "answer":
          "We accept UPI, debit/credit cards, net banking, and supported wallets.",
    },
    {
      "question": "Item is missing or incorrect, what do I do?",
      "answer":
          "Open the order → Help → Report an issue and choose the appropriate option for quick resolution.",
    },
  ];

  /// Filtered list used by the UI
  final RxList<Map<String, String>> filteredFaqs =
      <Map<String, String>>[].obs;

  /// (Optional) bind to a TextField if you want controller-side access
  final TextEditingController searchController = TextEditingController();

  /// Keep the latest query (used if you later add category filters)
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with full list
    filteredFaqs.assignAll(allFaqs);
  }

  /// Called from the TextField: onChanged => controller.searchFaq(value)
  void searchFaq(String query) {
    searchQuery.value = query;
    final q = query.trim().toLowerCase();

    if (q.isEmpty) {
      filteredFaqs.assignAll(allFaqs);
      return;
    }

    filteredFaqs.assignAll(
      allFaqs.where((item) {
        final question = (item["question"] ?? "").toLowerCase();
        final answer = (item["answer"] ?? "").toLowerCase();
        return question.contains(q) || answer.contains(q);
      }).toList(),
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
