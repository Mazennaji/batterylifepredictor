import 'package:flutter/material.dart';
import 'Battery.dart';
import 'drainer.dart';
import 'Usageintensity.dart';
import 'DeviceType.dart';
import 'combinedCheckbox.dart';
import 'Settings.dart';
class Home extends StatefulWidget {
  const  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  Battery selectedBattery = devices[0];
  String usage = 'Light';
  bool showResult = false;
  double displayedBatteryLife = 0.0;
  void updateUsage(String newUsage) {
    setState(() {
      usage = newUsage;
    });
  }
  void updateBattery(Battery battery) {
    setState(() {
      selectedBattery = battery;
    });
  }
  double getUsageDrain() {
    if (usage == 'Light') return 150;
    if (usage == 'Moderate') return 200;
    return 300; // High
  }
  double calculateBatteryLife() {
    double totalDrain = getUsageDrain();
    for (var drainer in drainers) {
      if (drainer.isSelected) {
        totalDrain += drainer.extraDrain;
      }
    }
    if (totalDrain <= 0 || totalDrain.isNaN) return 0.0;
    return selectedBattery.capacity / totalDrain;
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      screenWidth = screenWidth * 0.8;
    }
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Battery Calculator",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        elevation: 2,
        actions: [
            TextButton(onPressed:(){
              ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text('You are already on Home')),
    );
    },
        child: Text('Home', style: TextStyle(fontSize: 18, color: Colors.white))
            ),
            TextButton(onPressed:(){
            Navigator.pushNamed(context,'/settings');
            },
            child:Text('Settings',style:TextStyle(fontSize:18,color:Colors.white),))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCenteredCard(
                title: "Select Device",
                icon: Icons.smartphone,
                child: Devicetype(updateBattery: updateBattery),
              ),
              const SizedBox(height: 16),
              _buildCenteredCard(
                title: "Usage Intensity",
                icon: Icons.speed,
                child: Usageintensity(
                  battery: selectedBattery,
                  updateUsage: updateUsage,
                ),
              ),
              const SizedBox(height: 16),
              _buildCenteredCard(
                title: "Select Drainers",
                icon: Icons.power_settings_new,
                child: CombinedCheckbox(
                  drainers: drainers,
                  onUpdate: () => setState(() {}),
                ),
              ),
              const SizedBox(height: 20),
              _buildCenteredResultCard(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildCenteredCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.blue.shade700, size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(child: child),
        ],
      ),
    );
  }
  Widget _buildCenteredResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showResult) ...[
            Text(
              "Estimated Battery Life",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "${(displayedBatteryLife.isNaN ? 0.0 : displayedBatteryLife).toStringAsFixed(2)} hours",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 20),
          ],
          ElevatedButton(
            onPressed: () {
              setState(() {
                displayedBatteryLife = calculateBatteryLife(); // new value
                showResult = true; // show text
              });
            },
            style: ElevatedButton.styleFrom(
              padding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              backgroundColor: Colors.blue.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Show Estimated Battery Life",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
