import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../const/color.dart';
import '../../controllers/booking_form_controller.dart';
import '../../models/booking_model.dart';
import '../admin/view_booking_details.dart';

class BookingCalender extends ConsumerStatefulWidget {
  const BookingCalender({super.key});

  @override
  ConsumerState<BookingCalender> createState() => _BookingCalenderState();
}

class _BookingCalenderState extends ConsumerState<BookingCalender> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    User? user = FirebaseAuth.instance.currentUser;
    String? userId = user?.uid;
    ref
        .read(bookingControllerProvider.notifier)
        .fetchBookingsByMechanic(userId!);
  }

  @override
  Widget build(BuildContext context) {
    final bookings = ref.watch(bookingControllerProvider);

    final bookingsMap = _mapBookingsByDate(bookings);
    return Scaffold(
      appBar: AppBar(title: const Text('Bookings Calendar')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              print('Selected day: $_selectedDay');

              final normalizedSelectedDay = DateTime(
                _selectedDay.year,
                _selectedDay.month,
                _selectedDay.day,
              );

              final bookingsForSelectedDay =
                  bookingsMap[normalizedSelectedDay] ?? [];
            },
          ),
          Expanded(
            child: _buildBookingList(bookingsMap[DateTime(
                  _selectedDay.year,
                  _selectedDay.month,
                  _selectedDay.day,
                )] ??
                []),
          ),
        ],
      ),
    );
  }

  Map<DateTime, List<BookingModel>> _mapBookingsByDate(
      List<BookingModel> bookings) {
    final Map<DateTime, List<BookingModel>> bookingsMap = {};

    for (var booking in bookings) {
      final date = DateTime(
        booking.startDateTime!.year,
        booking.startDateTime!.month,
        booking.startDateTime!.day,
      );
      if (!bookingsMap.containsKey(date)) {
        bookingsMap[date] = [];
      }
      bookingsMap[date]!.add(booking);
    }

    return bookingsMap;
  }

  Widget _buildBookingList(List<BookingModel> bookings) {
    if (bookings.isEmpty) {
      return const Center(child: Text('No bookings on this day.'));
    }

    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: ColorList.blue, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: Text(
              booking.bookingTitle ?? 'No title',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Customer: ${booking.customerName ?? 'No name'}'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewBookingDetails(booking: booking),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
