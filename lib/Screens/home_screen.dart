import 'package:flutter/material.dart';
import '../widgets/home_cell.dart';
import '../models/book.dart';
import 'library_screen.dart';
import 'details_screen.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/Home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<Book> books;
  Book? selectedBook;

  @override
  void initState() {
    super.initState();
    books = [
      Book("To All the Boys I've Loved Before", 30, "assets/book7.jpg"),
      Book("Bridgerton - The Viscount Who Loved Me", 35, "assets/book6.jpg"),
      Book("Fifty Shades Darker", 28, "assets/book5.jpg"),
      Book("Sin Eater", 25, "assets/book3.jpg"),
      Book("Harry Potter & the Deathly Hallows", 40, "assets/book2.jpg"),
      Book("The White Raven", 33, "assets/book4.jpg"),
      Book("City of Orange", 29, "assets/book1.jpg"),
    ];
    selectedBook = books.isNotEmpty ? books[0] : null;
  }

  Widget _buildList(BuildContext context, bool isWide) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: books.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final book = books[index];
        return InkWell(
          onTap: () {
            if (isWide) {
              setState(() => selectedBook = book);
            } else {
              // Normal route (MaterialPageRoute) navigation to DetailsScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailsScreen(book: book)),
              );
            }
          },
          child: HomeCell(book: book),
        );
      },
    );
  }

  Widget _buildDetailPane(Book book) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(book.image,
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 300,
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 16),
          Text(book.name,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Price: ${book.price} DT",
              style: const TextStyle(fontSize: 18, color: Colors.black87)),
          const SizedBox(height: 12),
          const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus sit amet.")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;

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
      drawer: const CustomDrawer(),
      body: isWide
          ? Row(
              children: [
                // List pane
                Flexible(flex: 1, child: _buildList(context, true)),
                // Detail pane
                VerticalDivider(width: 1, color: Colors.grey[300]),
                Flexible(
                  flex: 2,
                  child: selectedBook != null
                      ? _buildDetailPane(selectedBook!)
                      : const Center(child: Text('Select a book')),
                ),
              ],
            )
          : _buildList(context, false),
    );
  }
}
