import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/booking_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _db;

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _init();
    return _db!;
  }

  Future<Database> _init() async {
    String p = join(await getDatabasesPath(), 'rent_car_db.db');
    return await openDatabase(
      p,
      version: 1,
      onCreate: (db, v) async {
        await db.execute('''
          CREATE TABLE bookings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            carId TEXT,
            carName TEXT,
            carImage TEXT,
            pickupDate TEXT,
            returnDate TEXT,
            pickupLocation TEXT,
            dropoffLocation TEXT,
            totalCost REAL,
            bookingDate TEXT,
            status TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertBooking(Booking b) async {
    final client = await database;
    return await client.insert('bookings', b.toMap());
  }

  Future<List<Booking>> getBookings() async {
    final client = await database;
    final res = await client.query('bookings', orderBy: 'bookingDate DESC');
    return res.isNotEmpty ? res.map((m) => Booking.fromMap(m)).toList() : [];
  }

  Future<void> deleteBooking(int id) async {
    final client = await database;
    await client.delete('bookings', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateStatus(int id, String status) async {
    final client = await database;
    await client.update('bookings', {'status': status}, where: 'id = ?', whereArgs: [id]);
  }
}
