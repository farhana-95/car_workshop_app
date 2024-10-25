import 'package:car_workshop_app/screens/mechanic/booking_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/color.dart';
import '../../controllers/auth_controller.dart';

class MechanicScreen extends ConsumerStatefulWidget {
  const MechanicScreen({super.key});

  @override
  ConsumerState<MechanicScreen> createState() => _MechanicScreenState();
}

class _MechanicScreenState extends ConsumerState<MechanicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Service',
          style: TextStyle(color: ColorList.blue),
        ),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
              onPressed: () async {
                await ref.read(authControllerProvider.notifier).signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const BookingList()),
                  );
                },
                child: _buildDashboardCard(
                  title: 'View Booking List',
                  icon: Icons.event_available,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildDashboardCard({
    required String title,
    required IconData icon,
  }) {
    return Card(
      color: ColorList.lightBlue,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: ColorList.white,
              size: 30,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: ColorList.white,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: ColorList.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
