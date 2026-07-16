class Booking {
  final int? id;
  final String carId;
  final String carName;
  final String carImage;
  final DateTime pickupDate;
  final DateTime returnDate;
  final String pickupLocation;
  final String dropoffLocation;
  final double totalCost;
  final DateTime bookingDate;
  final String status; // e.g., "Confirmed", "Completed", "Cancelled"

  Booking({
    this.id,
    required this.carId,
    required this.carName,
    required this.carImage,
    required this.pickupDate,
    required this.returnDate,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.totalCost,
    required this.bookingDate,
    this.status = "Confirmed",
  });

  // Convert a Booking into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'carId': carId,
      'carName': carName,
      'carImage': carImage,
      'pickupDate': pickupDate.toIso8601String(),
      'returnDate': returnDate.toIso8601String(),
      'pickupLocation': pickupLocation,
      'dropoffLocation': dropoffLocation,
      'totalCost': totalCost,
      'bookingDate': bookingDate.toIso8601String(),
      'status': status,
    };
  }

  // Extract a Booking object from a Map.
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      carId: map['carId'],
      carName: map['carName'],
      carImage: map['carImage'],
      pickupDate: DateTime.parse(map['pickupDate']),
      returnDate: DateTime.parse(map['returnDate']),
      pickupLocation: map['pickupLocation'],
      dropoffLocation: map['dropoffLocation'],
      totalCost: map['totalCost'],
      bookingDate: DateTime.parse(map['bookingDate']),
      status: map['status'],
    );
  }
}
