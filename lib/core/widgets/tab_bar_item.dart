import 'package:flutter/material.dart';

class TabBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool isSelected;
  final void Function(int) onItemTapped;

  const TabBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Row(
          children: [
            AnimatedScale(
              scale: isSelected ? 1.2 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Icon(
                icon,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: isSelected
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
