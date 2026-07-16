import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/car_provider.dart';
import '../constants/app_colors.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late RangeValues _price;
  late String _brand;
  late String _cat;

  @override
  void initState() {
    super.initState();
    final p = Provider.of<CarProvider>(context, listen: false);
    _price = p.priceRange;
    _brand = p.selectedBrand;
    _cat = p.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CarProvider>(context);
    bool dark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: dark ? AppColors.cardDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Filters', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  setState(() {
                    _price = const RangeValues(0, 1500);
                    _brand = 'All';
                    _cat = 'All';
                  });
                },
                child: const Text('Reset', style: TextStyle(color: Colors.redAccent)),
              ),
            ],
          ),
          const SizedBox(height: 25),

          _label('Price Range'),
          RangeSlider(
            values: _price,
            min: 0,
            max: 1500,
            divisions: 15,
            activeColor: AppColors.primary,
            labels: RangeLabels('\$${_price.start.round()}', '\$${_price.end.round()}'),
            onChanged: (v) => setState(() => _price = v),
          ),
          const SizedBox(height: 20),

          _label('Brand'),
          const SizedBox(height: 10),
          _chipList(provider.brands, _brand, (s) => setState(() => _brand = s)),
          
          const SizedBox(height: 20),

          _label('Category'),
          const SizedBox(height: 10),
          _chipList(provider.categories, _cat, (s) => setState(() => _cat = s)),
          
          const SizedBox(height: 40),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                provider.setFilters(priceRange: _price, brand: _brand, category: _cat);
                Navigator.pop(context);
              },
              child: const Text('Apply', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600));

  Widget _chipList(List<String> items, String selected, Function(String) onSelect) {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          final item = items[i];
          final active = selected == item;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(item, style: TextStyle(fontSize: 12, color: active ? Colors.black : null)),
              selected: active,
              onSelected: (b) => onSelect(item),
              selectedColor: AppColors.primary,
            ),
          );
        },
      ),
    );
  }
}
