import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 141, 210, 226),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, size: 50,),
            ),
            SizedBox(height: 20),
            Center(child: Text('Jatindra Nath Mishra', textScaler: TextScaler.linear(1.5))),
            Text('jatindranath.mishra@breadfinancial.com'),
            Text('+91 8637250822'),
          ],
        ),
    );
  }
}
