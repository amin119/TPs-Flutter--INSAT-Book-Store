import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/library_cell.dart';

class LibraryScreen extends StatelessWidget {
  final List<Book> books;
  final bool showAppBar;

  const LibraryScreen({super.key, required this.books, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    final content = Padding(
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
    );

    if (showAppBar) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Library", style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: const Color.fromARGB(255, 33, 107, 235),
        ),
        body: content,
      );
    }

    // When embedded (e.g., inside a TabBarView), return the content without a
    // Scaffold/AppBar so the parent AppBar remains the single top bar.
    return content;
  }
}
