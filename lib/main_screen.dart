import 'package:flutter/material.dart';
import 'homepage.dart';
import 'bills.dart';
import 'prediction.dart';
import 'tips.dart';
import 'bill_model.dart';
import 'login_page.dart';

class MainScreen extends StatefulWidget {
  final String userName; // 👈 RECEIVE USER NAME

  const MainScreen({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Bill> savedBills = [];
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      EnergyCostCalculator(
        onSaveBill: (bill) {
          setState(() {
            savedBills.add(bill);
          });
        },
      ),
      BillsPage(bills: savedBills),
      PredictionPage(bills: savedBills),
      const TipsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const mediumBlue = Color(0xFF1976D2);

    return Scaffold(
      // 🔹 TOP BAR WITH PROFILE ICON
      appBar: AppBar(
        backgroundColor: mediumBlue,
        title: const Text('Electricity Cost Calculator'),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.account_circle, size: 30),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),

      // 🔹 PROFILE DRAWER
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: mediumBlue),
              accountName: Text(
                widget.userName, // 👈 DYNAMIC USER NAME
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text("Logged User"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: mediumBlue),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text("Change Password"),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (_) => const ChangePasswordDialog(),
                );
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                  ),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),

      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: mediumBlue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Bills',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Prediction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Tips',
          ),
        ],
      ),
    );
  }
}

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final oldPass = TextEditingController();
    final newPass = TextEditingController();

    return AlertDialog(
      title: const Text("Change Password"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: oldPass,
            obscureText: true,
            decoration: const InputDecoration(labelText: "Old Password"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: newPass,
            obscureText: true,
            decoration: const InputDecoration(labelText: "New Password"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Password changed successfully"),
              ),
            );
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
