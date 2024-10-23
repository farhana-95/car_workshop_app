import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerInfoTab extends ConsumerWidget {
  final TabController tabController;

  const CustomerInfoTab({super.key, required this.tabController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerNameController = TextEditingController();
    final customerPhoneController = TextEditingController();
    final customerEmailController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Customer Information',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextFormField(
            controller: customerNameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            controller: customerPhoneController,
            decoration: const InputDecoration(labelText: 'Phone Number'),
          ),
          TextFormField(
            controller: customerEmailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              tabController.animateTo(2); // Move to the next tab
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
