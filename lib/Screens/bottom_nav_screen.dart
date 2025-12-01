import 'package:flutter/material.dart';
import '../models/book.dart';
import 'home_screen.dart';
import '../theme_controller.dart';
import 'library_screen.dart';
import 'basket_screen.dart';
import '../widgets/custom_drawer.dart';

class BottomNavScreen extends StatefulWidget {
  static const String routeName = "/BottomNav";
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int mCurrentIndex = 0;

  final List<Widget> pages = [
    ResponsiveHome(books: [
      Book("To All the Boys I've Loved Before", 30, "assets/book7.jpg"),
      Book("Bridgerton - The Viscount Who Loved Me", 35, "assets/book6.jpg"),
      Book("Fifty Shades Darker", 28, "assets/book5.jpg"),
      Book("Sin Eater", 25, "assets/book3.jpg"),
      Book("Harry Potter & the Deathly Hallows", 40, "assets/book2.jpg"),
      Book("The White Raven", 33, "assets/book4.jpg"),
      Book("City of Orange", 29, "assets/book1.jpg"),
    ]),
    LibraryScreen(books: [
      Book("To All the Boys I've Loved Before", 30, "assets/book7.jpg"),
      Book("Bridgerton - The Viscount Who Loved Me", 35, "assets/book6.jpg"),
      Book("Fifty Shades Darker", 28, "assets/book5.jpg"),
      Book("Sin Eater", 25, "assets/book3.jpg"),
      Book("Harry Potter & the Deathly Hallows", 40, "assets/book2.jpg"),
      Book("The White Raven", 33, "assets/book4.jpg"),
      Book("City of Orange", 29, "assets/book1.jpg"),
    ], showAppBar: false),
    const BasketScreen(showAppBar: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Provide the drawer so the hamburger can open navigation mode options
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF216BEF), Color(0xFF4A90E2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          // change title depending on the selected tab
          ['Store INSAT', 'Library', 'Basket'][mCurrentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6_outlined),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: pages[mCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: mCurrentIndex,
        onTap: (value) => setState(() => mCurrentIndex = value),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline), label: "Library"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: "Basket"),
        ],
      ),
    );
  }
}
