import 'package:car_workshop_app/controllers/booking_form_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_workshop_app/const/color.dart';
import 'package:car_workshop_app/models/booking_model.dart';
import 'package:car_workshop_app/screens/admin/view_booking_details.dart';

class BookingList extends ConsumerStatefulWidget {
  const BookingList({super.key});

  @override
  ConsumerState<BookingList> createState() => _BookingListState();
}

class _BookingListState extends ConsumerState<BookingList> {
  List<BookingModel> _bookings = [];

  @override
  void initState() {
    _fetchBookings();
    super.initState();
  }

  Future<void> _fetchBookings() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? userId = user?.uid;
    if (userId != null) {
      final bookings = await ref
          .read(bookingControllerProvider.notifier)
          .fetchBookingsByMechanic(userId);

      setState(() {
        _bookings = bookings;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bookings List',
          style: TextStyle(color: ColorList.blue),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: _bookings.isEmpty
                  ? const Center(
                      child: Text('No bookings found.',
                          style: TextStyle(fontSize: 18, color: Colors.grey)))
                  : ListView.builder(
                      itemCount: _bookings.length,
                      itemBuilder: (context, index) {
                        final booking = _bookings[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            leading: Icon(Icons.assignment,
                                color: Theme.of(context).primaryColor),
                            title: Text(
                              booking.bookingTitle ?? 'No Title',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Customer: ${booking.customerName ?? 'No Name'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ViewBookingDetails(booking: booking),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
