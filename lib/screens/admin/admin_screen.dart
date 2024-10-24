import 'package:car_workshop_app/screens/admin/car_booking_form.dart';
import 'package:flutter/material.dart';
import '../../const/color.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: ColorList.blue),
        ),
        centerTitle: true,
        elevation: 2,
        // backgroundColor: ColorList.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CarBookingForm()),
                );
              },
              child: _buildDashboardCard(
                title: 'Create New Booking',
                icon: Icons.add_circle_outline,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: (){},
              child: _buildDashboardCard(
                title: 'View Bookings',
                icon: Icons.event_note_outlined,
              ),
            ),
          ],
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
