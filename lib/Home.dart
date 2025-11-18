import 'package:flutter/material.dart';
import 'Battery.dart';
import 'drainer.dart';
import 'Usageintensity.dart';
import 'DeviceType.dart';
import 'combinedCheckbox.dart';
    class Home extends StatefulWidget {
      const Home({super.key});
      @override
      State<Home> createState() => _HomeState();
    }
    class _HomeState extends State<Home> {
      Battery selectedBattery = devices[0];   // default device
      String usage = 'Light';
      // Update usage from the radio buttons
      void updateUsage(String newUsage) {
        setState(() {
          usage = newUsage;
        });
      }
      // Update battery from dropdown
      void updateBattery(Battery battery) {
        setState(() {
          selectedBattery = battery;
        });
      }
      // Calculate total drain based on the usage from user
      double getUsageDrain() {
        if (usage == 'Light') return 150;
        if (usage == 'Moderate') return 200;
        return 300; // High
      }
      // Calculate total battery life
      double calculateBatteryLife() {
        double totalDrain = getUsageDrain();

        for (var drainer in drainers) {
          if (drainer.isSelected) {
            totalDrain += drainer.extraDrain;
          }
        }
        return selectedBattery.capacity / totalDrain;
      }
      @override
      Widget build(BuildContext context) {
        double batteryLife = calculateBatteryLife();
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
                  // ------------------- BATTERY RESULT -------------------
                  _buildCenteredResultCard(batteryLife),
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
      Widget _buildCenteredResultCard(double batteryLife) {
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
                "${batteryLife.toStringAsFixed(2)} hours",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
        );
      }
    }
