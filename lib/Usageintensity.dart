import 'Battery.dart';
import 'package:flutter/material.dart';
class Usageintensity extends StatefulWidget {
  Battery battery;
  final Function(String) updateUsage;
  Usageintensity({required this.battery,required this.updateUsage,super.key});
  @override
  State<Usageintensity> createState() => _UsageintensityState();
}
class _UsageintensityState extends State<Usageintensity> {
  String usage='Light';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio(
            value: 'Light',
            groupValue: usage,
            onChanged: (val) {
              setState(() {
                usage = val as String;
                widget.updateUsage(usage);
              });
            },
          ),
          const Text('Light', style: TextStyle(fontSize: 18)),

          const SizedBox(width: 10),

          Radio(
            value: 'Moderate',
            groupValue: usage,
            onChanged: (val) {
              setState(() {
                usage = val as String;
                widget.updateUsage(usage);
              });
            },
          ),
          const Text('Moderate', style: TextStyle(fontSize: 18)),

          const SizedBox(width: 10),

          Radio(
            value: 'High',
            groupValue: usage,
            onChanged: (val) {
              setState(() {
                usage = val as String;
                widget.updateUsage(usage);
              });
            },
          ),
          const Text('High', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
