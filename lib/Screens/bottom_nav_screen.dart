import 'package:flutter/material.dart';
import '../models/book.dart';
import 'home_screen.dart';
import 'library_screen.dart';
import 'basket_screen.dart';

class BottomNavScreen extends StatefulWidget {
  static const String routeName = "/BottomNav";
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int mCurrentIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    LibraryScreen(books: [
      Book("The Hobbit", 29, "assets/book2.jpg"),
      Book("The Lord of the Rings", 39, "assets/book4.jpg"),
    ]),
    const BasketScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
