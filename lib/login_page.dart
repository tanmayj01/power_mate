import 'package:flutter/material.dart';
import 'main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    final id = idController.text.trim();
    final password = passwordController.text.trim();

    // 🔹 Validation
    if (id.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter User ID and Password"),
        ),
      );
      return;
    }

    // ✅ ANY ID & PASSWORD ACCEPTED (Frontend Demo)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(
          userName: id, // 👈 PASS USER ID TO MAIN SCREEN
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const mediumBlue = Color(0xFF1976D2);

    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.login,
                    size: 60,
                    color: mediumBlue,
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    "PowerMate Login",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔹 USER ID FIELD
                  TextField(
                    controller: idController,
                    decoration: const InputDecoration(
                      labelText: "User ID",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 🔹 PASSWORD FIELD
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔹 LOGIN BUTTON
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mediumBlue,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: login,
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 16),
                    ),
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
