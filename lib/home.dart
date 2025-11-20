import 'package:flutter/material.dart';
import 'Battery.dart';
import 'drainer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Battery selectedBattery = devices[0];
  String usage = 'Light';
  bool showResult = false;
  double displayedBatteryLife = 0.0;
  double displayedEnergyImpact = 0.0;

  void updateUsage(String newUsage) {
    setState(() {
      usage = newUsage;
      showResult = false;
    });
  }

  void updateBattery(Battery battery) {
    setState(() {
      selectedBattery = battery;
      showResult = false;
    });
  }

  double getUsageDrain() {
    if (usage == 'Light') return 150;
    if (usage == 'Moderate') return 200;
    return 300;
  }

  double calculateBatteryLife() {
    double total = getUsageDrain();
    for (var d in drainers) {
      if (d.isSelected) total += d.extraDrain;
    }
    return selectedBattery.capacity / total;
  }

  double calculateEnergyImpact() {
    double total = getUsageDrain();
    for (var d in drainers) {
      if (d.isSelected) total += d.extraDrain;
    }
    return total / 100;
  }

  @override
  Widget build(BuildContext context) {
    bool dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: dark ? Colors.grey.shade900 : Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: dark ? Colors.black : Colors.blue.shade700,
        title: const Text(
          "Battery Calculator",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          _nav("Home", '/'),
          _nav("Settings", '/settings'),
          _nav("About", '/about'),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _deviceCard(dark),
              const SizedBox(height: 16),
              _usageCard(dark),
              const SizedBox(height: 16),
              _drainerCard(dark),
              const SizedBox(height: 24),
              _resultCard(dark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nav(String text, String route) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, route),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget _deviceCard(bool dark) {
    return _card(
      dark,
      "Select Device",
      Icons.devices,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _deviceBtn(Icons.computer, "Laptop", devices[0], dark),
          _deviceBtn(Icons.phone_android, "Mobile", devices[1], dark),
          _deviceBtn(Icons.tablet, "Tablet", devices[2], dark),
        ],
      ),
    );
  }

  Widget _deviceBtn(IconData icon, String label, Battery battery, bool dark) {
    bool selected = selectedBattery == battery;
    return Column(
      children: [
        IconButton(
          icon: Icon(
            icon,
            size: 35,
            color: selected
                ? (dark ? Colors.white : Colors.blue)
                : Colors.grey,
          ),
          onPressed: () => updateBattery(battery),
        ),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: dark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _usageCard(bool dark) {
    return _card(
      dark,
      "Usage Intensity",
      Icons.speed,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _usageOption(Icons.light_mode, "Light", dark),
          const SizedBox(width: 20),
          _usageOption(Icons.pie_chart, "Moderate", dark),
          const SizedBox(width: 20),
          _usageOption(Icons.local_fire_department, "High", dark),
        ],
      ),
    );
  }

  Widget _usageOption(IconData icon, String level, bool dark) {
    bool selected = usage == level;
    return Row(
      children: [
        Icon(
          icon,
          size: 22,
          color: selected
              ? (dark ? Colors.white : Colors.blue)
              : Colors.grey,
        ),
        Radio(
          value: level,
          groupValue: usage,
          onChanged: (value) => updateUsage(value.toString()),
        ),
        Text(
          level,
          style: TextStyle(
            fontSize: 16,
            color: dark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _drainerCard(bool dark) {
    return _card(
      dark,
      "Select Drainers",
      Icons.power_settings_new,
      Column(
        children: [
          _drainerRow(Icons.wifi, drainers[0], dark),
          const SizedBox(height: 10),
          _drainerRow(Icons.bluetooth, drainers[1], dark),
          const SizedBox(height: 10),
          _drainerRow(Icons.volume_up, drainers[2], dark),
        ],
      ),
    );
  }

  Widget _drainerRow(IconData icon, Drainer d, bool dark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 26,
          color: d.isSelected
              ? (dark ? Colors.white : Colors.blue)
              : Colors.grey,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              d.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: dark ? Colors.white : Colors.black,
              ),
            ),
            Text(
              "Extra drain: ${d.extraDrain} mAh/hr",
              style: TextStyle(
                fontSize: 13,
                color: dark ? Colors.grey.shade300 : Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Checkbox(
          value: d.isSelected,
          onChanged: (v) {
            setState(() {
              d.isSelected = v!;
              showResult = false;
            });
          },
        ),
      ],
    );
  }

  Widget _resultCard(bool dark) {
    return _card(
      dark,
      "Estimated Battery Life",
      Icons.battery_full,
      Column(
        children: [
          if (showResult)
            Text(
              "${displayedBatteryLife.toStringAsFixed(2)} hours",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: dark ? Colors.white : Colors.blue.shade700,
              ),
            ),
          if (showResult) const SizedBox(height: 20),
          if (showResult) batteryGauge(displayedEnergyImpact, dark),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                displayedBatteryLife = calculateBatteryLife();
                displayedEnergyImpact = calculateEnergyImpact();
                showResult = true;
              });
            },
            icon: Icon(
              Icons.bolt,
              color: dark ? Colors.black : Colors.white,
            ),
            label: Text(
              "Show Estimated Battery Life",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: dark ? Colors.black : Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: dark ? Colors.white : Colors.blue.shade700,
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 24,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget batteryGauge(double impact, bool dark) {
    double value = impact;
    if (value < 0) value = 0;
    if (value > 5) value = 5;

    Color color = Colors.green;
    if (value >= 3) {
      color = Colors.red;
    } else if (value >= 2) {
      color = Colors.yellow;
    }

    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 100,
          child: CustomPaint(
            painter: GaugePainter(value, color, dark),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value >= 3
              ? "High Energy Impact"
              : value >= 2
              ? "Medium Energy Impact"
              : "Low Energy Impact",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _card(bool dark, String title, IconData icon, Widget child) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: dark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: dark ? Colors.grey.shade700 : Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: dark ? Colors.white : Colors.blue.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: dark ? Colors.white : Colors.blue.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class GaugePainter extends CustomPainter {
  final double value;
  final Color color;
  final bool dark;

  GaugePainter(this.value, this.color, this.dark);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final backgroundPaint = Paint()
      ..color = dark ? Colors.grey.shade700 : Colors.grey.shade300
      ..strokeWidth = 18
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final foregroundPaint = Paint()
      ..color = color
      ..strokeWidth = 18
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 3.14, 3.14, false, backgroundPaint);
    canvas.drawArc(rect, 3.14, 3.14 * (value / 5), false, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
