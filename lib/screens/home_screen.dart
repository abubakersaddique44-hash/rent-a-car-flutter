import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/car_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/car_card.dart';
import '../widgets/category_selector.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../constants/app_colors.dart';
import 'car_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final cars = Provider.of<CarProvider>(context);
    final u = auth.user;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Welcome,', style: TextStyle(color: Colors.grey, fontSize: 15)),
                        Text(u?.name ?? 'Guest', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person_pin, color: Colors.black),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (v) => cars.setSearchQuery(v),
                  decoration: InputDecoration(
                    hintText: 'Find your ride...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.tune_rounded),
                      onPressed: () => _openFilters(context),
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.white10 : Colors.grey[100],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              CategorySelector(
                list: cars.categories,
                selected: cars.selectedCategory,
                onSelect: (val) => cars.setCategory(val),
              ),

              const SizedBox(height: 30),

              _header('Featured', () {}),
              SizedBox(
                height: 310,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: cars.featuredCars.length,
                  itemBuilder: (ctx, i) {
                    final car = cars.featuredCars[i];
                    return CarCard(
                      car: car,
                      onTap: () => _details(context, car),
                      onFav: () => cars.toggleFavorite(car.id),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              _header('Recommended', null),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: cars.cars.length > 10 ? 10 : cars.cars.length,
                itemBuilder: (ctx, i) {
                  final car = cars.cars[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CarCard(
                      car: car,
                      width: null,
                      onTap: () => _details(context, car),
                      onFav: () => cars.toggleFavorite(car.id),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const FilterBottomSheet(),
    );
  }

  void _details(BuildContext context, dynamic car) {
    Navigator.push(context, MaterialPageRoute(builder: (c) => CarDetailsScreen(car: car)));
  }

  Widget _header(String title, VoidCallback? onMore) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
          if (onMore != null)
            TextButton(onPressed: onMore, child: const Text('View all', style: TextStyle(color: AppColors.primary))),
        ],
      ),
    );
  }
}
