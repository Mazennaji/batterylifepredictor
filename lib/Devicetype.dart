import 'Battery.dart'; //used for dropdown menu
import 'package:flutter/material.dart';
class Devicetype extends StatefulWidget {
  final Function(Battery) updateBattery; //defined function for callback to setstate in home to initialize the objects
  const Devicetype({required this.updateBattery,super.key});
  @override
  State<Devicetype> createState() => _State();
}
class _State extends State<Devicetype> {
  @override
  Widget build(BuildContext context) {
    return const DropdownMenu(
      width:240,
      initialSelection:,
      dropdownMenuEntries:,
    );
  }
}
