import '../models/book.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/book_service.dart';
import '../services/cloud_book_service.dart';

final ValueNotifier<int> quantity = ValueNotifier<int>(10); // global stock counter

class DetailsScreen extends StatefulWidget {
  static const String routeName = "/Details";
  final Book book;
  const DetailsScreen({super.key, required this.book});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use theme's scaffold background so dark mode is respected
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        // prefer the app's AppBarTheme color so the bar matches the rest of the app
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: Text(
          widget.book.name,
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor ?? Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis, // avoids overflow for long titles
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DetailsContent(book: widget.book),
        ],
      ),
    );
  }
}

class DetailsContent extends StatelessWidget {
  final Book book;
  const DetailsContent({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
            child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
        // Use the theme card color so in dark mode the image frame becomes dark
        // and in light mode it remains the pale framed look.
        color: Theme.of(context).cardColor,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.45,
              alignment: Alignment.center,
              child: Image.asset(book.image, fit: BoxFit.contain),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // description uses theme text color so it's visible in dark mode
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
              "Suspendisse lectus tortor, dignissim sit amet, ultricies sed, dolor. "
              "Cras elementum ultrices diam.",
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            "${book.price} DT",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<int>(
          valueListenable: quantity,
          builder: (context, value, _) => Center(
            child: Text(
              "Stock: $value",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              if (quantity.value > 0) {
                // decrease stock
                quantity.value--;
                // insert into local DB basket
                try {
                  await BookService().insertBook(book);
                  // also add to cloud (associate with anonymous uid if available)
                  try {
                    final uid = FirebaseAuth.instance.currentUser?.uid;
                    await CloudBookService().addBook(book, ownerId: uid);
                  } catch (_) {
                    // ignore cloud errors but continue
                  }
                  // show a short success dialog that auto dismisses (rounded, themed)
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (dialogContext) {
                      // auto close after a short delay
                      Future.delayed(const Duration(milliseconds: 1600), () {
                        if (Navigator.of(dialogContext).canPop()) Navigator.of(dialogContext).pop();
                      });

                      final cardColor = Theme.of(context).cardColor;
                      final textColor = ThemeData.estimateBrightnessForColor(cardColor) == Brightness.dark
                          ? Colors.white
                          : Colors.black87;

                      return Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        backgroundColor: cardColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Success', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
                              const SizedBox(height: 8),
                              Text('Book added successfully', style: TextStyle(fontSize: 14, color: textColor)),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => AlertDialog(title: const Text('Error'), content: Text('DB error: $e')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Out of stock!")));
              }
            },
            icon: const Icon(Icons.shopping_bag),
            label: const Text("Purchase", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
