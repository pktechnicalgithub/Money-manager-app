import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_3_1/moneycontroller.dart';

class Addtransaction extends StatefulWidget {
  const Addtransaction({super.key});

  @override
  State<Addtransaction> createState() => _AddtransactionState();
}

class _AddtransactionState extends State<Addtransaction> {
  Moneycontroller moneycontroller = Get.find<Moneycontroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Transaction"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Dropdown
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Obx(
                    () => DropdownButton<String>(
                      value: moneycontroller.transactiontype.value,
                      items: [
                        DropdownMenuItem(
                            child: Text("Income"), value: "Income"),
                        DropdownMenuItem(
                            child: Text("Expense"), value: "Expense"),
                      ],
                      onChanged: (value) {
                        moneycontroller.transactiontype.value = value!;
                      },
                    ),
                  ),
                ),
              ],
            ),

            // Amount
            TextFormField(
              controller: moneycontroller.amountcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.currency_rupee),
                fillColor: Colors.grey.shade100,
                filled: true,
                hintText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Title
            TextFormField(
              controller: moneycontroller.titlecontroller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.title),
                fillColor: Colors.grey.shade100,
                filled: true,
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Note
            TextFormField(
              controller: moneycontroller.notecontroller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.note),
                fillColor: Colors.grey.shade100,
                filled: true,
                hintText: 'Note',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => moneycontroller.addtransaction(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 187, 232),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Add Transaction",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
