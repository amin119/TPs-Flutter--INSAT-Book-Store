import 'package:flutter/material.dart';
import '../models/book.dart';

class HomeCell extends StatelessWidget {
  final Book book;

  const HomeCell({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    // Determine a readable text color for content placed over the card color
    final cardColor = Theme.of(context).cardColor;
    final cardBrightness = ThemeData.estimateBrightnessForColor(cardColor);
    final onCardTextColor = cardBrightness == Brightness.dark ? Colors.white : Colors.black87;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Theme.of(context).cardColor,
        child: Container(
          height: 130,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Row(
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    book.image,
                    width: 80,
                    height: 110,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),

                // Right-aligned title and price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        book.name,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: onCardTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${book.price} TND",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: onCardTextColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
