import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CategorySelector extends StatelessWidget {
  final List<String> list;
  final String selected;
  final Function(String) onSelect;

  const CategorySelector({
    super.key,
    required this.list,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: list.length,
        itemBuilder: (context, i) {
          final item = list[i];
          final isActive = item == selected;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(item),
              selected: isActive,
              onSelected: (val) => val ? onSelect(item) : null,
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isActive ? Colors.black : (isDark ? Colors.white : Colors.black87),
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
              backgroundColor: isDark ? AppColors.cardDark : Colors.grey[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }
}
