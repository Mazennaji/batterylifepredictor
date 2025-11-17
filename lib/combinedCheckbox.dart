import 'package:flutter/material.dart';
import 'drainer.dart';

class CombinedCheckbox extends StatefulWidget {
  final List<Drainer> drainers;           // list of drainers to show
  final Function()? onUpdate;             // optional callback

  const CombinedCheckbox({
    required this.drainers,
    this.onUpdate,
    super.key,
  });

  @override
  State<CombinedCheckbox> createState() => _CombinedCheckboxState();
}

class _CombinedCheckboxState extends State<CombinedCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.drainers.map((drainer) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,   // CENTER EVERYTHING
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox
              Checkbox(
                value: drainer.isSelected,
                onChanged: (bool? selected) {
                  setState(() {
                    drainer.isSelected = selected!;
                  });
                  if (widget.onUpdate != null) widget.onUpdate!();
                },
              ),

              // Name + Subtitle
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // text still left-aligned under each other
                children: [
                  Text(
                    drainer.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Extra drain: ${drainer.extraDrain} mAh/hr",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
