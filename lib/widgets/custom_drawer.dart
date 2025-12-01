import 'package:flutter/material.dart';
import '../Screens/bottom_nav_screen.dart';
import '../Screens/tab_bar_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine current route name to toggle appropriately
    final String? current = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset("assets/Logo_INSAT.png", width: 100),
            ),
            const SizedBox(height: 20),
            // Single toggle ListTile: when tapped it switches navigation modes
            ListTile(
              leading: const Icon(Icons.navigation),
              title: const Text('Tabs Navigation'),
              onTap: () {
                Navigator.pop(context); // close drawer first
                // Toggle between TabBar and BottomNav depending on current route
                if (current == MyTabBar.routeName) {
                  Navigator.pushReplacementNamed(context, BottomNavScreen.routeName);
                } else {
                  Navigator.pushReplacementNamed(context, MyTabBar.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
