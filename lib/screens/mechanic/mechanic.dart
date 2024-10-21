import 'package:flutter/material.dart';

class MechanicScreen extends StatefulWidget {
  const MechanicScreen({super.key});

  @override
  State<MechanicScreen> createState() => _MechanicScreenState();
}

class _MechanicScreenState extends State<MechanicScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Center(child: Text('Mechanic Screen'))
          ],
        ),
      ),
    );
  }
}
