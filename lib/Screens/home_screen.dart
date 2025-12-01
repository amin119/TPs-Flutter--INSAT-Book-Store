import 'package:flutter/material.dart';
import '../widgets/home_cell.dart';
import '../models/book.dart';
// library_screen import removed (not used in HomeScreen AppBar anymore)
import 'details_screen.dart';
import '../theme_controller.dart';
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
      // keep the drawer available, but we'll render our own header in the body
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          // Custom header that replaces AppBar to avoid duplicates
          SafeArea(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF216BEF), Color(0xFF4A90E2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  // Top row: hamburger + centered title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                    child: Row(
                      children: [
                        // manual hamburger to open the drawer
                        IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Store INSAT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // theme toggle on the right to balance the row
                        IconButton(
                          icon: const Icon(Icons.brightness_6_outlined, color: Colors.white),
                          onPressed: () {
                            // import happens at top of file
                            toggleTheme();
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Color.fromARGB(80, 255, 255, 255), height: 1),
                  // Icon row
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        _TopBarField(icon: Icons.home, label: 'Home'),
                        _TopBarField(icon: Icons.bookmark, label: 'Library'),
                        _TopBarField(icon: Icons.shopping_bag, label: 'Basket'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // content list
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: HomeList(books: books),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBarField extends StatelessWidget {
  final IconData icon;
  final String label;
  const _TopBarField({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}

class HomeList extends StatelessWidget {
  final List<Book> books;
  const HomeList({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: books.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final book = books[index];
        return GestureDetector(
          onTap: () {
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
    );
  }
}

class ResponsiveHome extends StatefulWidget {
  final List<Book> books;
  const ResponsiveHome({super.key, required this.books});

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 700) {
          // Two-pane layout: list on left, details on right
          return Row(
            children: [
              SizedBox(
                width: 360,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                    itemCount: widget.books.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final book = widget.books[index];
                      return InkWell(
                        onTap: () => setState(() => selectedIndex = index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedIndex == index ? Colors.grey[200] : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Image.asset(book.image, width: 48, height: 70, fit: BoxFit.cover),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(book.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(child: DetailsContent(book: widget.books[selectedIndex])),
                ),
              ),
            ],
          );
        }

        // Small screen: use single-pane list that navigates to details
        return HomeList(books: widget.books);
      },
    );
  }
}
