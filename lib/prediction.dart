import 'package:flutter/material.dart';
import 'bill_model.dart';

class PredictionPage extends StatelessWidget {
  final List<Bill> bills;

  const PredictionPage({
    Key? key,
    required this.bills,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const mediumBlue = Color(0xFF1976D2);
    const lightBlueBg = Color(0xFFE3F2FD);

    // 🔹 Calculate total daily cost
    double totalDailyCost = 0;
    for (var bill in bills) {
      totalDailyCost += bill.dailyCost;
    }

    // 🔹 Monthly prediction ONLY
    double monthlyPrediction = totalDailyCost * 30;

    return Scaffold(
      backgroundColor: lightBlueBg,
      appBar: AppBar(
        title: const Text("Monthly Bill Prediction"),
        backgroundColor: mediumBlue,
        centerTitle: true,
      ),
      body: bills.isEmpty
          ? const Center(
        child: Text(
          "No saved bills to predict",
          style: TextStyle(fontSize: 16),
        ),
      )
          : Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.trending_up,
                    size: 70,
                    color: mediumBlue,
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    "Predicted Monthly Bill",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "₹ ${monthlyPrediction.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: mediumBlue,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Divider(),

                  const SizedBox(height: 8),

                  const Text(
                    "Based on your appliance usage",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
