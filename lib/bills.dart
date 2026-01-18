import 'package:flutter/material.dart';
import 'bill_model.dart';

class BillsPage extends StatelessWidget {
  final List<Bill> bills;

  const BillsPage({
    Key? key,
    required this.bills,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bills"),
        backgroundColor: const Color(0xFF1976D2),
      ),
      body: bills.isEmpty
          ? const Center(
        child: Text(
          "No bills saved",
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: bills.length,
        itemBuilder: (context, index) {
          final bill = bills[index];

          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.receipt_long,
                color: Color(0xFF1976D2),
              ),

              // 🔹 DEVICE NAME
              title: Text(
                bill.deviceName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  "Daily: ₹ ${bill.dailyCost.toStringAsFixed(2)}\n"
                      "Monthly: ₹ ${bill.monthlyCost.toStringAsFixed(2)}\n"
                      "Yearly: ₹ ${bill.yearlyCost.toStringAsFixed(2)}",
                ),
              ),

              trailing: Text(
                bill.date,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}
