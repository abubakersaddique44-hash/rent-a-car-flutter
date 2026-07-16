import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class MockMap extends StatelessWidget {
  final String label;

  const MockMap({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    bool dark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF242424) : const Color(0xFFE5E3DF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: dark ? Colors.white10 : Colors.black12),
      ),
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: _MapPainter(dark: dark),
          ),
          
          const Positioned(
            top: 40,
            left: 80,
            child: Icon(Icons.directions_car, color: Colors.blueAccent, size: 22),
          ),
          const Positioned(
            bottom: 30,
            right: 100,
            child: Icon(Icons.directions_car, color: Colors.greenAccent, size: 22),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
                const Icon(Icons.location_on, color: AppColors.primary, size: 38),
              ],
            ),
          ),

          Positioned(
            right: 10,
            bottom: 10,
            child: Column(
              children: [
                _mapBtn(Icons.add),
                const SizedBox(height: 4),
                _mapBtn(Icons.remove),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mapBtn(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
      ),
      child: Icon(icon, size: 18, color: Colors.black87),
    );
  }
}

class _MapPainter extends CustomPainter {
  final bool dark;
  _MapPainter({required this.dark});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = dark ? Colors.white10 : Colors.black12
      ..strokeWidth = 2;

    canvas.drawLine(Offset(0, size.height * 0.35), Offset(size.width, size.height * 0.45), p);
    canvas.drawLine(Offset(0, size.height * 0.75), Offset(size.width, size.height * 0.65), p);
    canvas.drawLine(Offset(size.width * 0.35, 0), Offset(size.width * 0.45, size.height), p);
    canvas.drawLine(Offset(size.width * 0.75, 0), Offset(size.width * 0.65, size.height), p);
  }

  @override
  bool shouldRepaint(CustomPainter old) => false;
}
