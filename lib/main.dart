import 'package:flutter/material.dart';
import 'Screens/signup_screen.dart';
import 'Screens/home_screen.dart';
import 'Screens/bottom_nav_screen.dart';
import 'Screens/tab_bar_screen.dart';
import 'Screens/details_screen.dart';
import 'models/book.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store INSAT',
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      // SignUpScreen is now the initial route
      initialRoute: SignUpScreen.routeName,
      routes: {
        SignUpScreen.routeName: (context) => SignUpScreen(
          onThemeChange: () {
            setState(() {
              isDark = !isDark;
            });
          },
        ),
        HomeScreen.routeName: (context) => const HomeScreen(),
        DetailsScreen.routeName: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Book;
          return DetailsScreen(book: args);
        },
        BottomNavScreen.routeName: (context) => const BottomNavScreen(),
        MyTabBar.routeName: (context) => const MyTabBar(),
      },
    );
  }
}
