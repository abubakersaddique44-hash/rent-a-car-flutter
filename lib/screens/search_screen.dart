import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/car_provider.dart';
import '../widgets/car_card.dart';
import '../widgets/category_selector.dart';
import '../widgets/filter_bottom_sheet.dart';
import 'car_details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CarProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Search'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (v) => provider.setSearchQuery(v),
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (ctx) => const FilterBottomSheet(),
                    );
                  },
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          CategorySelector(
            list: provider.categories,
            selected: provider.selectedCategory,
            onSelect: (v) => provider.setCategory(v),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: provider.cars.isEmpty
                ? const Center(child: Text('No results'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: provider.cars.length,
                    itemBuilder: (ctx, i) {
                      final c = provider.cars[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CarCard(
                          car: c,
                          width: null,
                          onTap: () {
                            Navigator.push(ctx, MaterialPageRoute(builder: (_) => CarDetailsScreen(car: c)));
                          },
                          onFav: () => provider.toggleFavorite(c.id),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
