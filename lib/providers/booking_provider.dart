import 'package:flutter/material.dart';
import '../database/sqlite/database_helper.dart';
import '../models/booking_model.dart';

class BookingProvider extends ChangeNotifier {
  List<Booking> _list = [];
  bool _busy = false;

  List<Booking> get bookings => _list;
  bool get isLoading => _busy;

  final _db = DatabaseHelper();

  BookingProvider() {
    fetch();
  }

  Future<void> fetch() async {
    _busy = true;
    notifyListeners();

    _list = await _db.getBookings();

    _busy = false;
    notifyListeners();
  }

  Future<bool> addBooking(Booking b) async {
    _busy = true;
    notifyListeners();

    try {
      final res = await _db.insertBooking(b);
      if (res > 0) {
        await fetch();
        return true;
      }
    } catch (err) {
      debugPrint('Booking error: $err');
    } finally {
      _busy = false;
      notifyListeners();
    }
    return false;
  }

  Future<void> cancel(int id) async {
    await _db.updateStatus(id, 'Cancelled');
    await fetch();
  }

  double calcTotal(double price, DateTime start, DateTime end) {
    int days = end.difference(start).inDays;
    return price * (days <= 0 ? 1 : days);
  }
}
