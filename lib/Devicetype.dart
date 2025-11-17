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
    return DropdownMenu(
      width:240,
      initialSelection:devices[0],
      onSelected:(battery){
        setState(() {
          widget.updateBattery(battery as Battery);/*when user selects an option the callback function executes and sends
          the object to the parent widget to set its state(this.battery=battery)*/
        });
      },
      dropdownMenuEntries:devices.map<DropdownMenuEntry<Battery>>((Battery battery){//maps the entries of the devices list as a dropdown
        return DropdownMenuEntry(value: battery, label:battery.name);

    }).toList(),
    );
  }
}
