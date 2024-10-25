import 'package:flutter/material.dart';

import '../../models/booking_model.dart';

class ViewBookingDetails extends StatelessWidget {
  final BookingModel booking;
  const ViewBookingDetails({super.key,required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Title
            Text(
              booking.bookingTitle ?? 'N/A',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Customer Name: ${booking.customerName ?? 'N/A'}',
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
            Text(
              'Phone: ${booking.customerPhone ?? 'N/A'}',
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
            Text(
              'Email: ${booking.customerEmail ?? 'N/A'}',
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
            const SizedBox(height: 12),
            Text(
              'Car Make: ${booking.carMake ?? 'N/A'}',
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
            Text(
              'Car Model: ${booking.carModel ?? 'N/A'}',
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
            Text(
              'Car Year: ${booking.carYear ?? 'N/A'}',
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
            Text(
              'Registration Plate: ${booking.registrationPlate ?? 'N/A'}',
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
            const SizedBox(height: 12),
            Text(
              'Start Date: ${booking.startDateTime?.toLocal().toString() ?? 'N/A'}',
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
            Text(
              'End Date: ${booking.endDateTime?.toLocal().toString() ?? 'N/A'}',
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
            const SizedBox(height: 12),
            Text(
              'Assigned Mechanic: ${booking.assignedMechanic ?? 'N/A'}',
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
            const SizedBox(height: 12),

          ],
        ),
      ),
    );
  }
}
