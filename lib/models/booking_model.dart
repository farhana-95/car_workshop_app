class BookingModel {
  final String? carMake;
  final String? carModel;
  final String? carYear;
  final String? registrationPlate;
  final String? customerName;
  final String? customerPhone;
  final String? customerEmail;
  final String? bookingTitle;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final String? assignedMechanic;
  final String? mechanicId;

  BookingModel({
    this.carMake,
    this.carModel,
    this.carYear,
    this.registrationPlate,
    this.customerName,
    this.customerPhone,
    this.customerEmail,
    this.bookingTitle,
    this.startDateTime,
    this.endDateTime,
    this.assignedMechanic,
    this.mechanicId
  });

  BookingModel copyWith({
    String? carMake,
    String? carModel,
    String? carYear,
    String? registrationPlate,
    String? customerName,
    String? customerPhone,
    String? customerEmail,
    String? bookingTitle,
    DateTime? startDateTime,
    DateTime? endDateTime,
    String? assignedMechanic,
    String? mechanicId,
  }) {
    return BookingModel(
      carMake: carMake ?? this.carMake,
      carModel: carModel ?? this.carModel,
      carYear: carYear ?? this.carYear,
      registrationPlate: registrationPlate ?? this.registrationPlate,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerEmail: customerEmail ?? this.customerEmail,
      bookingTitle: bookingTitle ?? this.bookingTitle,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      assignedMechanic: assignedMechanic ?? this.assignedMechanic,
      mechanicId: mechanicId ?? this.mechanicId
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'carMake': carMake,
      'carModel': carModel,
      'carYear': carYear,
      'registrationPlate': registrationPlate,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerEmail': customerEmail,
      'bookingTitle': bookingTitle,
      'startDateTime': startDateTime?.toIso8601String(),
      'endDateTime': endDateTime?.toIso8601String(),
      'assignedMechanic': assignedMechanic,
      'mechanicId': mechanicId,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      carMake: map['carMake'] ?? '',
      carModel: map['carModel'] ?? '',
      carYear: map['carYear'] ?? '',
      registrationPlate: map['registrationPlate'] ?? '',
      customerName: map['customerName'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      customerEmail: map['customerEmail'] ?? '',
      bookingTitle: map['bookingTitle'] ?? '',
      startDateTime: DateTime.parse(map['startDateTime']),
      endDateTime: DateTime.parse(map['endDateTime']),
      assignedMechanic: map['assignedMechanic'] ?? '',
        mechanicId: map['mechanicId'] ?? '',
    );
  }
}