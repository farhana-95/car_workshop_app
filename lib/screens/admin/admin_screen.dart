import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){},
              child: const Text('Create new booking'),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: (){},
              child: const Text('View bookings'),
            ),
          ],
        ),
      ),
    );
  }
}
