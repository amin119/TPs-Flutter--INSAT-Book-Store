import 'package:flutter/material.dart';
import '../models/book.dart';

int quantity = 10; // global stock counter

class DetailsScreen extends StatefulWidget {
  final Book book;
  const DetailsScreen({super.key, required this.book});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 107, 235),
        centerTitle: true,
        title: Text(
          widget.book.name,
          style: const TextStyle(
            color: Colors.white,
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

          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                widget.book.image,
                width: MediaQuery.of(context).size.width * 0.75, // 75% of screen width
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),


          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                "Suspendisse lectus tortor, dignissim sit amet, ultricies sed, dolor. "
                "Cras elementum ultrices diam.",
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 20),


          Center(
            child: Text(
              "${widget.book.price} DT",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),


          Center(
            child: Text(
              "Stock: $quantity",
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),


          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 33, 107, 235),
                foregroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                if (quantity > 0) {
                  setState(() {
                    quantity--;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "You purchased '${widget.book.name}'. Remaining: $quantity",
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Out of stock!")),
                  );
                }
              },
              icon: const Icon(Icons.shopping_bag),
              label: const Text(
                "Purchase",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
