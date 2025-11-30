import 'package:flutter/material.dart';
import '../models/book.dart';
import '../Screens/details_screen.dart';

class LibraryCell extends StatelessWidget {
  final Book book;
  const LibraryCell({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailsScreen(book: book)),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(book.image, width: 100, height: 120, fit: BoxFit.cover),
            ),
            const SizedBox(height: 8),
            Text(
              book.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
