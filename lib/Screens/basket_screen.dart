
import 'package:flutter/material.dart';

class BasketScreen extends StatelessWidget {
  final bool showAppBar;

  const BasketScreen({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    final content = const Center(
      child: Text('Basket Screen'),
    );

    if (showAppBar) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Basket', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: const Color.fromARGB(255, 33, 107, 235),
        ),
        body: content,
      );
    }

    return content;
  }
}
