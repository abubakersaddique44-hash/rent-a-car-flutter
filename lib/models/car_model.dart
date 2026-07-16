import 'package:hive/hive.dart';

part 'car_model.g.dart';

@HiveType(typeId: 0)
class Car extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String brand;

  @HiveField(2)
  final String model;

  @HiveField(3)
  final double pricePerDay;

  @HiveField(4)
  final double rating;

  @HiveField(5)
  final int reviewsCount;

  @HiveField(6)
  final List<String> images;

  @HiveField(7)
  final String description;

  @HiveField(8)
  final String category;

  @HiveField(9)
  final Map<String, String> specifications; // e.g., {"Engine": "2.0L", "Transmission": "Auto"}

  @HiveField(10)
  final bool isAvailable;

  @HiveField(11)
  bool isFavorite;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.pricePerDay,
    required this.rating,
    required this.reviewsCount,
    required this.images,
    required this.description,
    required this.category,
    required this.specifications,
    this.isAvailable = true,
    this.isFavorite = false,
  });

  String get fullName => '$brand $model';
}
