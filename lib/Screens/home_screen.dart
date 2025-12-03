import 'package:flutter/material.dart';
import '../widgets/home_cell.dart';
import '../models/book.dart';
import 'details_screen.dart';
import '../theme_controller.dart';
import '../widgets/custom_drawer.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/Home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We'll stream books from Firestore instead of using a static list

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

          // content list (real-time from Firestore)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder<List<Book>>(
                stream: FirestoreService.instance.booksStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final books = snapshot.data ?? [];
                  if (books.isEmpty) {
                    return const Center(child: Text('No books in the database'));
                  }
                  return HomeList(books: books);
                },
              ),
            ),
          ),
          // Floating action: add new book
          Padding(
            padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () => _showAddDialog(context),
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final _nameController = TextEditingController();
    final _priceController = TextEditingController();
    String selectedImage = 'assets/book1.jpg';

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Book'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedImage,
              items: [
                'assets/book1.jpg',
                'assets/book2.jpg',
                'assets/book3.jpg',
                'assets/book4.jpg',
                'assets/book5.jpg',
                'assets/book6.jpg',
                'assets/book7.jpg',
              ].map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
              onChanged: (v) {
                if (v != null) selectedImage = v;
              },
              decoration: const InputDecoration(labelText: 'Image'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final name = _nameController.text.trim();
              final price = int.tryParse(_priceController.text.trim()) ?? 0;
              if (name.isEmpty) return;
              final book = Book(name, price, selectedImage);
              await FirestoreService.instance.addBook(book);
              Navigator.pop(context);
            },
            child: const Text('Add'),
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
        return Dismissible(
          key: ValueKey(book.id.isNotEmpty ? book.id : index),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (_) async {
            // confirm
            final res = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirm delete'),
                content: Text('Delete "${book.name}"?'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                  ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
                ],
              ),
            );
            if (res != true) return false;
            if (book.id.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cannot delete local item')));
              return false;
            }
            try {
              await FirestoreService.instance.deleteBook(book.id);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deleted')));
              return true;
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
              return false;
            }
          },
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsScreen(book: book),
                ),
              );
            },
            child: HomeCell(book: book),
          ),
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
