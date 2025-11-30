import 'package:flutter/material.dart';
import '../models/book.dart';
import 'home_screen.dart';
import 'library_screen.dart';
import 'basket_screen.dart';

class MyTabBar extends StatefulWidget {
  static const String routeName = "/TabBar";
  const MyTabBar({super.key});

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final List<Book> books = [
      Book("The Hobbit", 29, "assets/book2.jpg"),
      Book("The Lord of the Rings", 39, "assets/book7.jpg"),
    ];

    final List<Widget> pages = [
      const HomeScreen(),
      LibraryScreen(books: books),
      const BasketScreen()
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 107, 235),
        title: const Text("Store INSAT",
            style: TextStyle(color: Colors.white, fontSize: 30)),
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.home_outlined), text: "Home"),
            Tab(icon: Icon(Icons.bookmark_outline), text: "Library"),
            Tab(icon: Icon(Icons.shopping_bag), text: "Basket"),
          ],
        ),
      ),
      body: TabBarView(controller: tabController, children: pages),
    );
  }
}
