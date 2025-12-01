import 'package:flutter/material.dart';
import 'Screens/signup_screen.dart';
import 'theme_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkTheme,
      builder: (context, isDark, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Store INSAT',
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF7F3F8),
            cardColor: const Color(0xFFFFFFFF),
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF216BEF)),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121212),
            cardColor: const Color(0xFFF7F3F8), // pale cards on dark background
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF216BEF)),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF121212),
              selectedItemColor: Color(0xFFBB86FC),
              unselectedItemColor: Colors.white54,
            ),
            textTheme: ThemeData.dark().textTheme.apply(bodyColor: Colors.white),
          ),
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          // SignUpScreen is now the initial route
          initialRoute: SignUpScreen.routeName,
          routes: {
            SignUpScreen.routeName: (context) => const SignUpScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            DetailsScreen.routeName: (context) {
              final args = ModalRoute.of(context)!.settings.arguments as Book;
              return DetailsScreen(book: args);
            },
            BottomNavScreen.routeName: (context) => const BottomNavScreen(),
            MyTabBar.routeName: (context) => const MyTabBar(),
          },
        );
      },
    );
  }
}
