import 'package:flutter/material.dart';
import 'bill_model.dart';

class EnergyCostCalculator extends StatefulWidget {
  final Function(Bill) onSaveBill;

  const EnergyCostCalculator({
    Key? key,
    required this.onSaveBill,
  }) : super(key: key);

  @override
  State<EnergyCostCalculator> createState() => _EnergyCostCalculatorState();
}

class _EnergyCostCalculatorState extends State<EnergyCostCalculator> {
  final TextEditingController powerController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController customDeviceController =
  TextEditingController();

  // 🔹 Device list
  final List<String> devices = [
    'Fan',
    'LED Bulb',
    'TV',
    'Refrigerator',
    'Washing Machine',
    'Air Conditioner',
    'Laptop',
    'Mobile Charger',
    'Other (Custom)',
  ];

  String selectedDevice = 'Fan';

  double costHour = 0;
  double costDay = 0;
  double costMonth = 0;
  double costYear = 0;
  double dailyUnit = 0;

  void calculate() {
    final power = double.tryParse(powerController.text) ?? 0;
    final hours = double.tryParse(hourController.text) ?? 0;
    final price = double.tryParse(priceController.text) ?? 0;

    dailyUnit = (power * hours) / 1000;
    costDay = dailyUnit * price;
    costHour = hours > 0 ? costDay / hours : 0;
    costMonth = costDay * 30;
    costYear = costDay * 365;

    setState(() {});
  }

  void saveBill() {
    if (costDay == 0) return;

    final deviceName = selectedDevice == 'Other (Custom)'
        ? customDeviceController.text.trim()
        : selectedDevice;

    widget.onSaveBill(
      Bill(
        deviceName:
        deviceName.isEmpty ? 'Unknown Device' : deviceName,
        dailyCost: costDay,
        monthlyCost: costMonth,
        yearlyCost: costYear,
        date: DateTime.now().toString().split(' ')[0],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Bill saved successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const mediumBlue = Color(0xFF1976D2);
    const lightBlueBg = Color(0xFFE3F2FD);

    return Scaffold(
      backgroundColor: lightBlueBg,
      appBar: AppBar(
        backgroundColor: mediumBlue,
        title: const Text('Electricity Cost Calculator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 DEVICE SELECTION
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButton<String>(
                  value: selectedDevice,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: devices.map((device) {
                    return DropdownMenuItem(
                      value: device,
                      child: Text(device),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDevice = value!;
                    });
                  },
                ),
              ),
            ),

            // 🔹 CUSTOM DEVICE NAME
            if (selectedDevice == 'Other (Custom)')
              Card(
                margin: const EdgeInsets.only(top: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.edit),
                  title: TextField(
                    controller: customDeviceController,
                    decoration: const InputDecoration(
                      hintText: "Enter device name",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 12),

            inputCard(
              Icons.flash_on,
              "Device power use (W)",
              powerController,
            ),
            inputCard(
              Icons.access_time,
              "Daily use time (H)",
              hourController,
            ),
            inputCard(
              Icons.currency_rupee,
              "Electricity price",
              priceController,
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mediumBlue,
                minimumSize: const Size(double.infinity, 52),
              ),
              onPressed: calculate,
              child: const Text("Calculate"),
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 52),
              ),
              onPressed: saveBill,
              child: const Text("Save Bill"),
            ),

            const SizedBox(height: 20),

            resultCard("Cost per hour", costHour),
            resultCard("Cost per day", costDay),
            resultCard("Cost per month", costMonth),
            resultCard("Cost per year", costYear),
            resultCard("Daily consumption (kWh)", dailyUnit),
          ],
        ),
      ),
    );
  }

  Widget inputCard(
      IconData icon,
      String hint,
      TextEditingController controller,
      ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFF1976D2),
        ),
        title: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget resultCard(String title, double value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value.toStringAsFixed(2),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1976D2),
          ),
        ),
      ),
    );
  }
}
