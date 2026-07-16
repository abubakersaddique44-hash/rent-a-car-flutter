import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../data/dummy_data.dart';
import '../database/hive/hive_helper.dart';

class CarProvider extends ChangeNotifier {
  List<Car> _allCars = [];
  List<Car> _filteredCars = [];
  
  String _search = '';
  String _category = 'All';
  RangeValues _price = const RangeValues(0, 1500);
  String _brand = 'All';

  List<Car> get cars => _filteredCars;
  String get searchQuery => _search;
  String get selectedCategory => _category;
  RangeValues get priceRange => _price;
  String get selectedBrand => _brand;

  CarProvider() {
    _initData();
  }

  Future<void> _initData() async {
    // Check Hive first
    _allCars = HiveHelper.getAllCars();
    
    // Seed dummy data if box is empty
    if (_allCars.isEmpty) {
      _allCars = DummyData.cars;
      await HiveHelper.saveCars(_allCars);
    }
    
    // Refresh favorite status from disk
    for (var car in _allCars) {
      car.isFavorite = HiveHelper.isFavorite(car.id);
    }
    
    _apply();
  }

  void setSearchQuery(String q) {
    _search = q;
    _apply();
  }

  void setCategory(String c) {
    _category = c;
    _apply();
  }

  void setFilters({RangeValues? priceRange, String? brand, String? category}) {
    if (priceRange != null) _price = priceRange;
    if (brand != null) _brand = brand;
    if (category != null) _category = category;
    _apply();
  }

  void resetFilters() {
    _category = 'All';
    _brand = 'All';
    _price = const RangeValues(0, 1500);
    _apply();
  }

  void _apply() {
    _filteredCars = _allCars.where((c) {
      final nameMatch = c.fullName.toLowerCase().contains(_search.toLowerCase());
      final catMatch = _category == 'All' || c.category == _category;
      final priceMatch = c.pricePerDay >= _price.start && c.pricePerDay <= _price.end;
      final brandMatch = _brand == 'All' || c.brand == _brand;
      
      return nameMatch && catMatch && priceMatch && brandMatch;
    }).toList();
    notifyListeners();
  }

  Future<void> toggleFavorite(String id) async {
    await HiveHelper.toggleFavorite(id);
    
    final i = _allCars.indexWhere((c) => c.id == id);
    if (i != -1) {
      _allCars[i].isFavorite = HiveHelper.isFavorite(id);
      notifyListeners();
    }
  }

  List<String> get categories {
    final res = {'All'};
    for (var c in _allCars) {
      res.add(c.category);
    }
    return res.toList()..sort();
  }

  List<String> get brands {
    final res = {'All'};
    for (var c in _allCars) {
      res.add(c.brand);
    }
    return res.toList()..sort();
  }

  List<Car> get favoriteCars => _allCars.where((c) => c.isFavorite).toList();

  List<Car> get featuredCars {
    // Show high rated cars as featured
    return _allCars.where((c) => c.rating >= 4.9).take(5).toList();
  }
}
