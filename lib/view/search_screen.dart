import 'package:flutter/material.dart';
import 'package:library_onlile/model/home_screen_model.dart';
import 'package:library_onlile/provider/home_screen_provider.dart';
import 'package:library_onlile/provider/search_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final String? selectedCategory;
  const SearchScreen({super.key, this.selectedCategory});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // Show all books
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final allBooks = context.read<HomeProvider>().books.cast<BookModel>();
      context.read<SearchProvider>().performSearch('', allBooks);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String query) {
    if (query.trim().isNotEmpty) {
      context.read<SearchProvider>().saveToRecentSearches(query.trim());
      FocusScope.of(context).unfocus();
    }
  }

  void _clearSearchField() {
    _searchController.clear();
    final allBooks = context.read<HomeProvider>().books.cast<BookModel>();
    context.read<SearchProvider>().performSearch('', allBooks);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();
    final homeProvider = context.watch<HomeProvider>();

    final queryText = _searchController.text.trim();

    final List<BookModel> booksToDisplay = queryText.isEmpty
        ? List<BookModel>.from(homeProvider.books)
        : searchProvider.searchResults;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, size: 30, color: Color(0xFF0F5555)),
        title: const Text(
          "Library",
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F5555),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Color(0xFF0F5555), size: 30),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Input Box
              TextFormField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onFieldSubmitted: _onSearchSubmitted,
                onChanged: (query) {
                  final allBooks = context.read<HomeProvider>().books;
                  context.read<SearchProvider>().performSearch(query, allBooks);
                  setState(() {});
                },
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 247, 247, 247),
                  filled: true,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: _clearSearchField,
                        )
                      : const Icon(Icons.mic_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Search by title, author, or ISBN...",
                ),
              ),
              const SizedBox(height: 20),
              // Loading State
              if (searchProvider.isLoading) ...[
                const SizedBox(height: 20),
                const Center(
                  child: CircularProgressIndicator(color: Color(0xFF0F5555)),
                ),
              ],

              // Recent Searches
              if (searchProvider.recentSearches.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Searches ",
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<SearchProvider>().clearRecentSearches();
                      },
                      child: const Text(
                        "Clear all",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F5555),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: searchProvider.recentSearches.map((searchedText) {
                    return GestureDetector(
                      onTap: () {
                        _searchController.text = searchedText;
                        _searchController
                            .selection = TextSelection.fromPosition(
                          TextPosition(offset: _searchController.text.length),
                        );
                        final allBooks = homeProvider.books.cast<BookModel>();
                        context.read<SearchProvider>().performSearch(
                          searchedText,
                          allBooks,
                        );
                        FocusScope.of(context).unfocus();
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 216, 230, 255),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.history,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              searchedText,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
              ],

              // Search Result Header
              Row(
                children: [
                  const Text(
                    "Search Result    ",
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "(${searchProvider.searchResults.length})",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              booksToDisplay.isEmpty
                  ? const Center(
                      child: Text(
                        "No books found.",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: booksToDisplay.length,
                      itemBuilder: (context, index) {
                        final book = booksToDisplay[index];
                        return Container(
                          height: 200,
                          padding: EdgeInsets.all(12),
                          margin: const EdgeInsets.only(right: 16, bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withAlpha(25),
                                blurRadius: 10,
                                offset: const Offset(2, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                  bottom: Radius.circular(12),
                                ),
                                child: Container(
                                  width: 120,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        book.image,
                                        width: double.infinity,
                                        height: 400,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Container(
                                          width: 40,
                                          height: 34,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              17,
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: const Icon(
                                              Icons.star_border,
                                              color: Color(0xFF8B6E28),
                                              size: 20,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.category.toUpperCase(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Times New Roman',
                                        fontSize: 16,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      book.title,
                                      style: TextStyle(
                                        fontFamily: 'Times New Roman',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      book.author,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(height: 40),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${book.rating.toString()} ",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                255,
                                                235,
                                                184,
                                                64,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
