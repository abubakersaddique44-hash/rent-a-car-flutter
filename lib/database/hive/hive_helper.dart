import 'package:hive_flutter/hive_flutter.dart';
import '../../models/car_model.dart';
import '../../models/user_model.dart';

class HiveHelper {
  static const _carBox = 'cars_box';
  static const _userBox = 'user_box';
  static const _favBox = 'fav_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    
    Hive.registerAdapter<Car>(CarAdapter());
    Hive.registerAdapter<User>(UserAdapter());

    await Hive.openBox<Car>(_carBox);
    await Hive.openBox<User>(_userBox);
    await Hive.openBox<String>(_favBox);
  }

  // Cars
  static List<Car> getAllCars() {
    return Hive.box<Car>(_carBox).values.toList();
  }

  static Future<void> saveCars(List<Car> cars) async {
    final box = Hive.box<Car>(_carBox);
    await box.clear();
    for (var c in cars) {
      await box.put(c.id, c);
    }
  }

  // User session
  static User? getUser() {
    return Hive.box<User>(_userBox).get('session_user');
  }

  static Future<void> saveUser(User u) async {
    await Hive.box<User>(_userBox).put('session_user', u);
  }

  static Future<void> clearUser() async {
    await Hive.box<User>(_userBox).clear();
  }

  // Favorites logic
  static bool isFavorite(String id) {
    return Hive.box<String>(_favBox).containsKey(id);
  }

  static Future<void> toggleFavorite(String id) async {
    final box = Hive.box<String>(_favBox);
    if (box.containsKey(id)) {
      await box.delete(id);
    } else {
      await box.put(id, id);
    }
  }
}
