import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:project_3_1/transactionmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Moneycontroller extends GetxController {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();

  RxString transactiontype = "Expense".obs;
  RxList<Transactionmodel> transactions = <Transactionmodel>[].obs;
  RxString profileImagePath = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
    loadProfileImage();
  }

  // ============ PROFILE IMAGE ============

  void pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      profileImagePath.value = image.path;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("profileImage", image.path);
    }
  }

  void loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedPath = prefs.getString("profileImage");
    if (savedPath != null) {
      profileImagePath.value = savedPath;
    }
  }

  // ============ TRANSACTIONS ============

  Future<void> loadTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? savedData = prefs.getStringList("transactions");
      if (savedData != null) {
        transactions.value = savedData
            .map((item) => Transactionmodel.fromJson(
                Map<String, dynamic>.from(jsonDecode(item))))
            .toList();
      }
    } catch (e) {
      print("Load error: $e");
    }
  }

  Future<void> saveTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> dataToSave =
          transactions.map((t) => jsonEncode(t.toJson())).toList();
      await prefs.setStringList("transactions", dataToSave);
    } catch (e) {
      print("Save error: $e");
    }
  }

  // ============ ADD TRANSACTION ============

  void addtransaction() async {
    if (amountcontroller.text.isEmpty || titlecontroller.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final int amount = int.tryParse(amountcontroller.text) ?? 0;
    final String type = transactiontype.value;

    final newtransaction = Transactionmodel(
      id: DateTime.now().toIso8601String(),
      amount: amount,
      title: titlecontroller.text,
      note: notecontroller.text,
      transactiontype: type,
    );

    transactions.add(newtransaction);
    saveTransactions();

    titlecontroller.clear();
    amountcontroller.clear();
    notecontroller.clear();

    Get.back();
    Get.snackbar(
      "Success",
      "Transaction Added!",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // ============ DELETE TRANSACTION ============

  void deleteTransaction(String id) {
    transactions.removeWhere((t) => t.id == id);
    saveTransactions();
    Get.snackbar(
      "Deleted",
      "Transaction removed!",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  int get totalIncome => transactions
      .where((t) => t.transactiontype == "Income")
      .fold(0, (sum, t) => sum + (t.amount ?? 0));

  int get totalExpense => transactions
      .where((t) => t.transactiontype == "Expense")
      .fold(0, (sum, t) => sum + (t.amount ?? 0));

  int get balance => totalIncome - totalExpense;
}
