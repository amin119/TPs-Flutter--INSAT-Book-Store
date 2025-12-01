import 'package:flutter/material.dart';
import '../models/book.dart';
import 'home_screen.dart';
import '../theme_controller.dart';
import 'library_screen.dart';
import 'basket_screen.dart';
import '../widgets/custom_drawer.dart';

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
      Book("To All the Boys I've Loved Before", 30, "assets/book7.jpg"),
      Book("Bridgerton - The Viscount Who Loved Me", 35, "assets/book6.jpg"),
      Book("Fifty Shades Darker", 28, "assets/book5.jpg"),
      Book("Sin Eater", 25, "assets/book3.jpg"),
      Book("Harry Potter & the Deathly Hallows", 40, "assets/book2.jpg"),
      Book("The White Raven", 33, "assets/book4.jpg"),
      Book("City of Orange", 29, "assets/book1.jpg"),
    ];

    final List<Widget> pages = [
      ResponsiveHome(books: books),
      LibraryScreen(books: books, showAppBar: false),
      const BasketScreen(showAppBar: false)
    ];

    return Scaffold(
      // drawer so the AppBar's hamburger opens the same navigation drawer
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 107, 235),
        centerTitle: true,
        title: const Text("Store INSAT",
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6_outlined),
            onPressed: toggleTheme,
          ),
        ],
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
