import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/library_cell.dart';

class LibraryScreen extends StatelessWidget {
  final List<Book> books;
  const LibraryScreen({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Library"),
        backgroundColor: const Color.fromARGB(255, 33, 107, 235),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 books per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            return LibraryCell(book: books[index]);
          },
        ),
      ),
    );
  }
}
