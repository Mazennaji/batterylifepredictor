import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About App"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: Icon(
                Icons.battery_full,
                size: 80,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Battery Life Predictor",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "This application helps you estimate the battery life of your device "
                  "based on usage intensity, selected features, device type, and battery capacity. "
                  "It is built using Flutter and demonstrates state management, navigation, "
                  "and UI design principles.",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            const Text(
              "Features:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "- Predict battery life based on usage\n"
                  "- Toggle dark mode & notifications\n"
                  "- Choose device type and battery model\n"
                  "- Interactive checkboxes for drain factors\n"
                  "- Clean UI with multiple pages",
              style: TextStyle(fontSize: 16),
            ),

            const Spacer(),

            Center(
              child: Text(
                "Developed by Mazen Naji and Samer Maarouf",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
