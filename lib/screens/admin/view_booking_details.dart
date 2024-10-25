import 'package:flutter/material.dart';

import 'package:car_workshop_app/models/booking_model.dart';

import '../../const/color.dart';

class ViewBookingDetails extends StatelessWidget {
  final BookingModel booking;
  const ViewBookingDetails({super.key,required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details',style: TextStyle(color: ColorList.blue),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    booking.bookingTitle ?? 'N/A',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            _buildInfoCard('Customer Information', [
              _buildInfoRow('Name', booking.customerName ?? 'N/A'),
              _buildInfoRow('Phone', booking.customerPhone ?? 'N/A'),
              _buildInfoRow('Email', booking.customerEmail ?? 'N/A'),
            ]),

            _buildInfoCard('Car Details', [
              _buildInfoRow('Make', booking.carMake ?? 'N/A'),
              _buildInfoRow('Model', booking.carModel ?? 'N/A'),
              _buildInfoRow('Year', booking.carYear ?? 'N/A'),
              _buildInfoRow('Registration Plate', booking.registrationPlate ?? 'N/A'),
            ]),

            _buildInfoCard('Booking Dates', [
              _buildInfoRow('Start Date', booking.startDateTime?.toLocal().toString() ?? 'N/A'),
              _buildInfoRow('End Date', booking.endDateTime?.toLocal().toString() ?? 'N/A'),
            ]),

            _buildInfoCard('Assigned Mechanic', [
              _buildInfoRow('', booking.assignedMechanic ?? 'N/A'),
            ]),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> content) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            ...content,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}