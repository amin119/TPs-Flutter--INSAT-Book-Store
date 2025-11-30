import 'package:flutter/material.dart';
import '../models/book.dart';

class HomeCell extends StatelessWidget {
  final Book book;

  const HomeCell({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // gives shadow (Material effect)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(8), // Step D: padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Image with rounded corners
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                book.image,
                width: 100,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),

            // Text Column (Title + Price)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  book.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${book.price} DT",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
