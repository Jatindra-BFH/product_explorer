import 'package:flutter/material.dart';

import '../utilities/screen.dart';
import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  final String title = "Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundColor: Color.fromARGB(255, 141, 210, 226),
            child: Icon(
              Icons.shopping_bag,
              size: 70,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Welcome to Product Explorer",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            "Browse and manage your products easily.\nUse the menu to explore products, adjust settings, or log out.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            icon: const Icon(Icons.list),
            label: const Text("Explore Products"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 141, 210, 226),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainScreen(currentScreen: Screen.Product_Explorer,)));
            },
          ),
        ],
      )
        )
    );
  }
}
