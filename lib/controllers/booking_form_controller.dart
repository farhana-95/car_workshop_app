import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/booking_model.dart';

final carInfoStateProvider =
    StateProvider.autoDispose<BookingModel>((ref) => BookingModel());
