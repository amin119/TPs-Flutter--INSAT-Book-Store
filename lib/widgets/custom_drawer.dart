import 'package:flutter/material.dart';
import '../Screens/bottom_nav_screen.dart';
import '../Screens/tab_bar_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Navigation Mode"),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset("assets/logo_INSAT.png", width: 100),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.navigation),
              title: const Text("Bottom Navigation"),
              onTap: () {
                Navigator.pushReplacementNamed(context, BottomNavScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tab),
              title: const Text("Tab Bar Navigation"),
              onTap: () {
                Navigator.pushReplacementNamed(context, MyTabBar.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
