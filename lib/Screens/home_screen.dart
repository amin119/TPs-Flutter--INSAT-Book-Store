import 'package:flutter/material.dart';
import '../widgets/home_cell.dart';
import '../models/book.dart';
import 'library_screen.dart';
import 'details_screen.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/Home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Book> books = [
      Book("To All the Boys I've Loved Before", 30, "assets/book7.jpg"),
      Book("Bridgerton - The Viscount Who Loved Me", 35, "assets/book6.jpg"),
      Book("Fifty Shades Darker", 28, "assets/book5.jpg"),
      Book("Sin Eater", 25, "assets/book3.jpg"),
      Book("Harry Potter & the Deathly Hallows", 40, "assets/book2.jpg"),
      Book("The White Raven", 33, "assets/book4.jpg"),
      Book("City of Orange", 29, "assets/book1.jpg"),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 107, 235),
        title: const Text(
          "Store INSAT",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.library_books, color: Colors.white),
            onPressed: () {
              // Route normale vers LibraryScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LibraryScreen(books: books),
                ),
              );
            },
          ),
        ],
      ),

      // ✅ Use the new CustomDrawer without arguments
      drawer: const CustomDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: books.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final book = books[index];
            return GestureDetector(
              onTap: () {
                // Navigation normale vers DetailsScreen avec argument
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsScreen(book: book),
                  ),
                );
              },
              child: HomeCell(book: book),
            );
          },
        ),
      ),
    );
  }
}
