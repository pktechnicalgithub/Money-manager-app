import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_3_1/addtransaction.dart';
import 'package:project_3_1/moneycontroller.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    Moneycontroller moneycontroller = Get.put(Moneycontroller());

    return Scaffold(
      appBar: AppBar(
        title: Text("Money Manager", style: TextStyle(color: Colors.black)),
        centerTitle: true,

        // Profile Photo — tap karo to gallery khulegi
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () {
              moneycontroller.pickProfileImage();
            },
            child: Obx(() => CircleAvatar(
                  backgroundImage: moneycontroller
                          .profileImagePath.value.isEmpty
                      ? AssetImage('images/profile.jpg') as ImageProvider
                      : FileImage(File(moneycontroller.profileImagePath.value)),
                )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(Addtransaction()),
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 10),

              // Balance Card
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 200, 143, 238),
                      const Color.fromARGB(255, 255, 201, 237),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 160,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Available Balance",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "₹${moneycontroller.balance}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Income & Expense Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Income
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 150,
                    width: 183,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_downward_rounded,
                            color: Colors.green, size: 38),
                        Text("Income",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400)),
                        Text("₹${moneycontroller.totalIncome}",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),

                  // Expense
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.pink[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 150,
                    width: 183,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_upward_rounded,
                            color: Colors.red, size: 38),
                        Text("Expense",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400)),
                        Text("₹${moneycontroller.totalExpense}",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              Row(
                children: [
                  Text(
                    "Recent Transactions",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ],
              ),

              SizedBox(height: 10),

              // Transaction List
              Expanded(
                child: moneycontroller.transactions.isEmpty
                    ? Center(
                        child: Text(
                          "No transactions yet!",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: moneycontroller.transactions.length,
                        itemBuilder: (context, index) {
                          var tx = moneycontroller.transactions[index];
                          bool isExpense = tx.transactiontype == "Expense";

                          return Dismissible(
                            key: Key(tx.id ?? index.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Icon(Icons.delete,
                                  color: Colors.white, size: 30),
                            ),
                            onDismissed: (direction) {
                              moneycontroller.deleteTransaction(tx.id ?? "");
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 75,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: isExpense
                                            ? Colors.pink[100]
                                            : Colors.green[100],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        isExpense
                                            ? Icons.arrow_upward_rounded
                                            : Icons.arrow_downward_rounded,
                                        color: isExpense
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tx.title ?? "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          tx.note ?? "",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.currency_rupee,
                                      color:
                                          isExpense ? Colors.red : Colors.green,
                                      size: 18,
                                    ),
                                    Text(
                                      "${tx.amount}",
                                      style: TextStyle(
                                        color: isExpense
                                            ? Colors.red
                                            : Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
