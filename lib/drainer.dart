import 'package:flutter/material.dart';
List<Drainer> drainers  = [
  Drainer(name: 'WIFI', extraDrain: 1.1),
  Drainer(name: 'Bluetooth', extraDrain: 1.5),
  Drainer(name: 'Volume', extraDrain: 1.2)
];
class Drainer {
  String name;       // public attribute
  double extraDrain; // extra battery drain per hour
  bool isSelected;   // is it turned on?

  // Constructor
  Drainer({
    required this.name,
    required this.extraDrain,
    this.isSelected = false,
  });

  // Toggle the drainer on/off
  void toggle() {
    isSelected = !isSelected;
  }
}
class combinedCheckbox extends StatefulWidget {
  const combinedCheckbox({super.key});

  @override
  State<combinedCheckbox> createState() => _combinedCheckboxState();
}

class _combinedCheckboxState extends State<combinedCheckbox> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

