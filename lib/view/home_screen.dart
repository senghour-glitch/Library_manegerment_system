import 'package:flutter/material.dart';
import 'package:library_onlile/model/homescreen_model.dart';
import 'package:library_onlile/provider/homescreen_provider.dart';
import 'package:library_onlile/view/notification_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color teal = Color(0xFF16414B);

  static const Color gold = Color(0xFF8A6D3B);

  static const Color background = Color(0xFFF7F6F4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,

        automaticallyImplyLeading: false,

        title: const Text(
          'Library',
          style: TextStyle(
            color: teal,
            fontFamily: 'Serif',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NotificationScreen()),
              );
            },
            icon: const Icon(Icons.notifications_none, color: teal),
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: Consumer<HomeScreenProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    'Welcome back ',
                    style: TextStyle(
                      color: teal,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Find your next favorite book.',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: TextField(
                      onChanged: provider.searchBooks,

                      decoration: const InputDecoration(
                        hintText: 'Search books...',
                        prefixIcon: Icon(Icons.search, color: teal),

                        border: InputBorder.none,

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                          color: teal,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                        ),
                      ),

                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See all',
                          style: TextStyle(
                            color: gold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  SizedBox(
                    height: 42,

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,

                      itemCount: provider.categories.length,

                      itemBuilder: (context, index) {
                        final category = provider.categories[index];

                        final bool selected =
                            provider.selectedCategory == category;

                        return Padding(
                          padding: const EdgeInsets.only(right: 10),

                          child: ChoiceChip(
                            label: Text(category),

                            selected: selected,

                            onSelected: (_) {
                              provider.selectCategory(category);
                            },

                            selectedColor: teal,

                            backgroundColor: Colors.white,

                            labelStyle: TextStyle(
                              color: selected ? Colors.white : teal,

                              fontWeight: FontWeight.w600,
                            ),

                            side: BorderSide(
                              color: selected ? teal : Colors.grey.shade300,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 28),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        'Popular Books',
                        style: TextStyle(
                          color: teal,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                        ),
                      ),

                      Text(
                        '${provider.filteredBooks.length} books',
                        style: const TextStyle(
                          color: gold,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  if (provider.filteredBooks.isEmpty)
                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(30),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: const Column(
                        children: [
                          Icon(
                            Icons.menu_book_outlined,
                            size: 60,
                            color: Colors.grey,
                          ),

                          SizedBox(height: 12),

                          Text(
                            'No books found',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            'Try another search or category.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),

                  if (provider.filteredBooks.isNotEmpty)
                    GridView.builder(
                      shrinkWrap: true,

                      physics: const NeverScrollableScrollPhysics(),

                      itemCount: provider.filteredBooks.length,

                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,

                            crossAxisSpacing: 16,

                            mainAxisSpacing: 18,

                            childAspectRatio: 0.60,
                          ),

                      itemBuilder: (context, index) {
                        final BookModel book = provider.filteredBooks[index];

                        return BookCard(book: book);
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final BookModel book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    const Color teal = Color(0xFF16414B);

    const Color gold = Color(0xFF8A6D3B);

    return InkWell(
      borderRadius: BorderRadius.circular(18),

      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Selected: ${book.title}')));
      },

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),

              blurRadius: 12,

              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Expanded(
              flex: 6,

              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),

                child: Image.network(
                  book.image,

                  width: double.infinity,

                  fit: BoxFit.cover,

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return Container(
                      color: Colors.grey.shade200,

                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: teal,
                        ),
                      ),
                    );
                  },

                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,

                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey,
                          size: 45,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Expanded(
              flex: 4,

              child: Padding(
                padding: const EdgeInsets.all(12),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // TITLE
                    Text(
                      book.title,

                      maxLines: 1,

                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        color: teal,

                        fontSize: 17,

                        fontWeight: FontWeight.bold,

                        fontFamily: 'Serif',
                      ),
                    ),

                    const SizedBox(height: 5),

                    // AUTHOR
                    Text(
                      book.author,

                      maxLines: 1,

                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        color: Colors.black54,

                        fontSize: 13,
                      ),
                    ),

                    const Spacer(),

                    // CATEGORY + RATING
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            book.category,

                            maxLines: 1,

                            overflow: TextOverflow.ellipsis,

                            style: const TextStyle(
                              color: gold,

                              fontSize: 11,

                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(width: 5),

                        const Icon(Icons.star, color: Colors.amber, size: 16),

                        const SizedBox(width: 3),

                        Text(
                          book.rating.toString(),

                          style: const TextStyle(
                            fontSize: 12,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
