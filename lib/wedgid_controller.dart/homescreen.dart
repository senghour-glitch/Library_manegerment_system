import 'package:flutter/material.dart';
import 'package:library_onlile/model/homescreen.dart';

class BookCard extends StatelessWidget {
  final BookModel book;

  const BookCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.asset(
                book.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            book.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(book.author),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star,
                  color: Colors.amber, size: 18),
              Text(book.rating.toString()),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}