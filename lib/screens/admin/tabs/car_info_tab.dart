import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarInfoTab extends ConsumerWidget {
  final TabController tabController;

  const CarInfoTab({super.key, required this.tabController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carMakeController = TextEditingController();
    final carModelController = TextEditingController();
    final carYearController = TextEditingController();
    final registrationPlateController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Car Information',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextFormField(
            controller: carMakeController,
            decoration: const InputDecoration(labelText: 'Make'),
          ),
          TextFormField(
            controller: carModelController,
            decoration: const InputDecoration(labelText: 'Model'),
          ),
          TextFormField(
            controller: carYearController,
            decoration: const InputDecoration(labelText: 'Year'),
          ),
          TextFormField(
            controller: registrationPlateController,
            decoration: const InputDecoration(labelText: 'Registration Plate'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              tabController.animateTo(1); // Move to the next tab
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
