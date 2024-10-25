import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:car_workshop_app/models/booking_model.dart';
import 'package:car_workshop_app/service/firebase.dart';

final carInfoStateProvider =
    StateProvider.autoDispose<BookingModel>((ref) => BookingModel());

final bookingControllerProvider =
    StateNotifierProvider<BookingController, List<BookingModel>>((ref) {
  final firebaseService = FirebaseService();
  return BookingController(firebaseService);
});

class BookingController extends StateNotifier<List<BookingModel>> {
  final FirebaseService _firebaseService;

  BookingController(this._firebaseService) : super([]);

  Future<void> fetchBookings() async {
    try {
      final bookingsData = await _firebaseService.fetchBookings();
      state = bookingsData;
    } catch (e) {
      print('Error fetching bookings: $e');
      state = [];
    }
  }


  Future<List<BookingModel>> fetchBookingsByMechanic(String mechanicId) async {
    try {
      final bookingsData = await _firebaseService.fetchBookingsByMechanic(mechanicId);
      return state = bookingsData;
    } catch (e) {
      print('Error fetching bookings: $e');
      return state = [];
    }
  }

  Future<void> addBooking(BookingModel booking) async {
    try {
      await _firebaseService.addBooking(booking.toMap());
      await fetchBookings();
    } catch (e) {
      print('Error adding booking data: $e');
    }
  }
}
