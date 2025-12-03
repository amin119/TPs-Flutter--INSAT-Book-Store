import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Screens/signup_screen.dart';
import 'theme_controller.dart';
import 'Screens/home_screen.dart';
import 'Screens/bottom_nav_screen.dart';
import 'Screens/tab_bar_screen.dart';
import 'Screens/details_screen.dart';
import 'models/book.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // enable offline persistence for Firestore (mobile default; explicit for clarity)
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
  // Optional: use local Firestore emulator when testing locally.
  // Enable by running Flutter with: --dart-define=USE_FIRESTORE_EMULATOR=true
  const bool _useFirestoreEmulator = bool.fromEnvironment('USE_FIRESTORE_EMULATOR', defaultValue: false);
  if (_useFirestoreEmulator) {
    // default emulator host/port used by `firebase emulators:start --only firestore`
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
  // sign in anonymously so we can associate docs to a user (optional)
  try {
    await FirebaseAuth.instance.signInAnonymously();
  } catch (_) {}
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
            // make cards truly dark in dark mode so the overall app looks fully dark
            cardColor: const Color(0xFF1E1E1E),
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
