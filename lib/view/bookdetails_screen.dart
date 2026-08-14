import 'package:flutter/material.dart';
import 'package:library_onlile/model/bookdetails_model.dart';
import 'package:library_onlile/model/categories_model.dart';
import 'package:library_onlile/provider/bookdetails_provider.dart';
import 'package:provider/provider.dart';


class BookDetailsScreen extends StatelessWidget {
  final CategoryModel category;
  final String? bookId;

  const BookDetailsScreen({super.key, required this.category, this.bookId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookDetailsProvider()
        ..fetchBookDetails(
          bookId ?? category.id,
          categoryId: category.id,
          fallbackImageUrl: category.imageUrl,
        ),
      child: const _BookDetailsView(),
    );
  }
}

class _BookDetailsView extends StatelessWidget {
  const _BookDetailsView();

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF16414B);
    const background = Color(0xFFF7F6F4);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: teal),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Details',
          style: TextStyle(
            color: teal,
            fontFamily: 'Serif',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.ios_share, color: teal), onPressed: () {}),
        ],
      ),
      body: Consumer<BookDetailsProvider>(
        builder: (context, provider, _) {
          switch (provider.status) {
            case BookDetailsStatus.initial:
            case BookDetailsStatus.loading:
              return const Center(child: CircularProgressIndicator(color: teal));

            case BookDetailsStatus.error:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Something went wrong.\n${provider.errorMessage ?? ''}',
                        textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => provider.fetchBookDetails(
                        provider.book?.id ?? '',
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );

            case BookDetailsStatus.loaded:
              final book = provider.book!;
              return _BookDetailsBody(book: book, provider: provider);
          }
        },
      ),
    );
  }
}

class _BookDetailsBody extends StatelessWidget {
  final BookdetailModel book;
  final BookDetailsProvider provider;

  const _BookDetailsBody({required this.book, required this.provider});

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF16414B);
    const gold = Color(0xFF8A6D3B);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                book.coverUrl,
                height: 320,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 320,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.menu_book, size: 48, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              book.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: teal,
                fontFamily: 'Serif',
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 6),
            Text(book.author, style: const TextStyle(color: Colors.black54, fontSize: 15)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  5,
                  (i) => Icon(
                    i < book.rating.round() ? Icons.star : Icons.star_border,
                    color: gold,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 6),
                Text('(${book.rating})', style: const TextStyle(color: Colors.black54)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _StatBox(icon: Icons.menu_book_outlined, label: 'Pages', value: '${book.pages}'),
                const SizedBox(width: 12),
                _StatBox(icon: Icons.public, label: 'Language', value: book.language),
                const SizedBox(width: 12),
                _StatBox(icon: Icons.archive_outlined, label: 'Copies', value: '${book.copies}'),
              ],
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Description',
                style: TextStyle(
                  color: teal,
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(book.description, style: const TextStyle(color: Colors.black87, height: 1.5)),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                children: book.tags
                    .map((t) => Chip(
                          label: Text(t),
                          backgroundColor: teal.withOpacity(0.08),
                          labelStyle: const TextStyle(color: teal),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: book.copies <= 0 || provider.isBorrowing
                    ? null
                    : () async {
                        await provider.borrowBook();
                        if (context.mounted && provider.borrowMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(provider.borrowMessage!)),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: teal,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                icon: provider.isBorrowing
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.bookmark_add_outlined, color: Colors.white),
                label: Text(
                  book.copies <= 0 ? 'OUT OF COPIES' : 'BORROW NOW',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatBox({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF16414B);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: teal.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: teal, size: 20),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(color: Colors.black54, fontSize: 12)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(color: teal, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}