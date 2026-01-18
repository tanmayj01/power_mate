import 'package:flutter/material.dart';
import 'login_page.dart'; // or main_screen.dart if no login

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(), // app starts here
    );
  }
}
