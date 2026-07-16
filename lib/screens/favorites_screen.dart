import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/car_provider.dart';
import '../widgets/car_card.dart';
import 'car_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CarProvider>(context);
    final favs = provider.favoriteCars;

    return Scaffold(
      appBar: AppBar(title: const Text('My Favorites'), centerTitle: true),
      body: favs.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favs.length,
              itemBuilder: (ctx, i) {
                final car = favs[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CarCard(
                    car: car,
                    width: null,
                    onTap: () {
                      Navigator.push(ctx, MaterialPageRoute(builder: (_) => CarDetailsScreen(car: car)));
                    },
                    onFav: () => provider.toggleFavorite(car.id),
                  ),
                );
              },
            ),
    );
  }
}
