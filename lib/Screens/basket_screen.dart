
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/home_cell.dart';
import '../services/cloud_book_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BasketScreen extends StatelessWidget {
  final bool showAppBar;

  const BasketScreen({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final body = StreamBuilder<List<Book>>(
      stream: CloudBookService().streamBooks(ownerId: uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Erreur : ${snapshot.error}', style: const TextStyle(color: Colors.red)),
          );
        }
        final books = snapshot.data ?? [];
        if (books.isEmpty) {
          return const Center(child: Text('Votre panier est vide'));
        }
        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) => HomeCell(book: books[index]),
        );
      },
    );

    if (showAppBar) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Basket', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: const Color.fromARGB(255, 33, 107, 235),
        ),
        body: body,
      );
    }

    return body;
  }
}
