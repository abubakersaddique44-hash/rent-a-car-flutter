import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String? profilePicture;

  @HiveField(4)
  final String? phoneNumber;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profilePicture,
    this.phoneNumber,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profilePicture,
    String? phoneNumber,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
