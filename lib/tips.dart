import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const mediumBlue = Color(0xFF1976D2);

    final List<Map<String, String>> tips = [
      {
        "title": "Use LED Bulbs",
        "desc": "LED bulbs consume up to 80% less electricity than traditional bulbs."
      },
      {
        "title": "Turn Off When Not in Use",
        "desc": "Switch off appliances when they are not required."
      },
      {
        "title": "Use Energy Efficient Appliances",
        "desc": "Choose appliances with high energy star ratings."
      },
      {
        "title": "Unplug Chargers",
        "desc": "Chargers consume power even when not charging."
      },
      {
        "title": "Limit Air Conditioner Usage",
        "desc": "Use AC only when required and keep temperature around 24°C."
      },
      {
        "title": "Regular Maintenance",
        "desc": "Clean fans, AC filters, and refrigerators regularly."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Energy Saving Tips"),
        backgroundColor: mediumBlue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.lightbulb_outline,
                color: mediumBlue,
                size: 30,
              ),
              title: Text(
                tips[index]["title"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  tips[index]["desc"]!,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
