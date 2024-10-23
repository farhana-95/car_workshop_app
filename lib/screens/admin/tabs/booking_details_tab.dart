import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingDetailsTab extends ConsumerWidget {
  const BookingDetailsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingTitleController = TextEditingController();
    final startDateTimeController = TextEditingController();
    final endDateTimeController = TextEditingController();
    String? selectedMechanic;
    List<String> mechanics = ['Mechanic 1', 'Mechanic 2', 'Mechanic 3'];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Booking Details',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextFormField(
            controller: bookingTitleController,
            decoration: const InputDecoration(labelText: 'Booking Title'),
          ),
          TextFormField(
            controller: startDateTimeController,
            decoration: const InputDecoration(labelText: 'Start DateTime'),
          ),
          TextFormField(
            controller: endDateTimeController,
            decoration: const InputDecoration(labelText: 'End DateTime'),
          ),
          const SizedBox(height: 16),
          const Text('Assign Mechanic',
              style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButtonFormField<String>(
            value: selectedMechanic,
            hint: const Text('Assign Mechanic'),
            onChanged: (newValue) {
              selectedMechanic = newValue;
            },
            items: mechanics.map((mechanic) {
              return DropdownMenuItem(
                value: mechanic,
                child: Text(mechanic),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
