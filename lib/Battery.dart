import 'drainer.dart';
List<Battery> devices = [
  Battery(name: 'Laptop' ,capacity: 5000.0),
  Battery(name: 'Phone' ,capacity: 3000.0),
  Battery(name: 'Tablet' ,capacity: 2000.0),
];
class Battery {
  String name;
  double capacity;      // total battery capacity
  List<Drainer> drainers; // list of optional drainers


  // Constructor
  Battery({
    required this.name,
    required this.capacity,
    List<Drainer>? drainers,
  }) : drainers = drainers ?? [];

  // Add a drainer to the battery
  void addDrainer(Drainer drainer) {
    drainers.add(drainer);
  }

  // Calculate total drain including selected drainers
  double _calculateTotalDrain() {
    double total = 0;
    String usage = '';
    if(usage == 'light'){total = 150;}
    else if (usage == 'medium'){total = 200;}
    else{total = 100;}
    for (var drainer in drainers) {
      if (drainer.isSelected) {
        total += drainer.extraDrain;
      }
    }
    return total;
  }

  // Public method to get battery life in hours
  double getBatteryLife() {
    double totalDrain = _calculateTotalDrain();
    return capacity / totalDrain;
  }

  // Public method to get charging time in hours
  double getChargeTime(double chargeSpeed) {
    return capacity / chargeSpeed;
  }

  // Display battery info
  void displayInfo() {
    print("Battery Capacity: $capacity mAh");
    print("Selected Drainers:");
    for (var drainer in drainers) {
      if (drainer.isSelected) {
        print("- ${drainer.name} (+${drainer.extraDrain} mAh/hour)");
      }
    }
    print("Estimated Battery Life: ${getBatteryLife().toStringAsFixed(2)} hours");
  }
}
