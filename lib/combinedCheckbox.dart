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
        return CheckboxListTile(
          title: Text(drainer.name, style: TextStyle(fontSize: 18)),
          subtitle: Text("Extra drain: ${drainer.extraDrain} mAh/hr"),
          value: drainer.isSelected,
          onChanged: (bool? selected) {
            setState(() {
              drainer.isSelected = selected!;
            });

            // Notify parent widget (optional)
            if (widget.onUpdate != null) widget.onUpdate!();
          },
        );
      }).toList(),
    );
  }
}
