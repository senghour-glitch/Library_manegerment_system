import 'package:flutter/material.dart';
import 'package:library_onlile/model/categories_model.dart';
import 'package:library_onlile/provider/categories_provider.dart';
import 'package:library_onlile/view/bookdetails_screen.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
  });

  @override
  State<CategoriesScreen> createState() =>
      _CategoriesScreenState();
}

class _CategoriesScreenState
    extends State<CategoriesScreen> {
  static const Color teal = Color(0xFF16414B);

  // static const Color gold = Color(0xFF8A6D3B);

  static const Color background =
      Color(0xFFF7F6F4);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<CategoriesProvider>()
          .fetchCategories();
    });
  }

  void _onCategoryTap(
    CategoryModel category,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BookDetailsScreen(
            category: category,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: teal,
          ),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),

        title: const Text(
          'Library',
          style: TextStyle(
            color: teal,
            fontFamily: 'Serif',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: teal,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                    'Search coming soon',
                  ),
                ),
              );
            },
          ),
        ],
      ),

      // =========================
      // BODY
      // =========================
      body: Consumer<CategoriesProvider>(
        builder: (
          context,
          provider,
          child,
        ) {
          // =========================
          // LOADING
          // =========================
          if (provider.status ==
                  CategoriesStatus.initial ||
              provider.status ==
                  CategoriesStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: teal,
              ),
            );
          }

          // =========================
          // ERROR
          // =========================
          if (provider.status ==
              CategoriesStatus.error) {
            return Center(
              child: Padding(
                padding:
                    const EdgeInsets.all(20),

                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,

                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    const Text(
                      'Something went wrong',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      provider.errorMessage ??
                          'Unknown error',
                      textAlign:
                          TextAlign.center,
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    ElevatedButton(
                      onPressed:
                          provider.fetchCategories,

                      child:
                          const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          // =========================
          // EMPTY
          // =========================
          if (provider.categories.isEmpty) {
            return const Center(
              child: Text(
                'No categories found',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }

          // =========================
          // LOADED
          // =========================
          return RefreshIndicator(
            onRefresh:
                provider.fetchCategories,

            child: CustomScrollView(
              physics:
                  const AlwaysScrollableScrollPhysics(),

              slivers: [
                // =========================
                // HEADER
                // =========================
                SliverPadding(
                  padding:
                      const EdgeInsets.fromLTRB(
                    20,
                    16,
                    20,
                    20,
                  ),

                  sliver:
                      SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: const [
                        Text(
                          'Categories',
                          style: TextStyle(
                            color: teal,
                            fontFamily: 'Serif',
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),

                        SizedBox(
                          height: 6,
                        ),

                        Text(
                          'Explore our curated collection of knowledge.',
                          style: TextStyle(
                            color:
                                Colors.black54,
                            fontSize: 15,
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),

                // =========================
                // CATEGORY GRID
                // =========================
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),

                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,

                      mainAxisSpacing: 16,

                      crossAxisSpacing: 16,

                      childAspectRatio: 0.78,
                    ),

                    delegate:
                        SliverChildBuilderDelegate(
                      (
                        context,
                        index,
                      ) {
                        final CategoryModel
                            category =
                            provider
                                .categories[
                            index];

                        return _CategoryCard(
                          category:
                              category,

                          onTap: () {
                            _onCategoryTap(
                              category,
                            );
                          },
                        );
                      },

                      childCount:
                          provider
                              .categories
                              .length,
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child:
                      SizedBox(height: 30),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ======================================================
// CATEGORY CARD
// ======================================================

class _CategoryCard
    extends StatelessWidget {
  final CategoryModel category;

  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color teal =
        Color(0xFF16414B);

    const Color gold =
        Color(0xFF8A6D3B);

    return InkWell(
      onTap: onTap,

      borderRadius:
          BorderRadius.circular(18),

      child: Container(
        padding:
            const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(
                0.06,
              ),

              blurRadius: 12,

              offset:
                  const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // =========================
            // IMAGE
            // =========================
            Expanded(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),

                child: Image.network(
                  category.imageUrl,

                  width:
                      double.infinity,

                  fit: BoxFit.cover,

                  // =========================
                  // LOADING IMAGE
                  // =========================
                  loadingBuilder:
                      (
                    context,
                    child,
                    loadingProgress,
                  ) {
                    if (loadingProgress ==
                        null) {
                      return child;
                    }

                    return Container(
                      color:
                          Colors.grey.shade200,

                      child:
                          const Center(
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                          color: teal,
                        ),
                      ),
                    );
                  },

                  // =========================
                  // ERROR IMAGE
                  // =========================
                  errorBuilder:
                      (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Container(
                      color:
                          Colors.grey.shade200,

                      child:
                          const Center(
                        child: Icon(
                          Icons
                              .image_not_supported_outlined,
                          color:
                              Colors.grey,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // =========================
            // TITLE
            // =========================
            Text(
              category.title,

              maxLines: 1,

              overflow:
                  TextOverflow.ellipsis,

              style: const TextStyle(
                color: teal,

                fontFamily: 'Serif',

                fontWeight:
                    FontWeight.bold,

                fontSize: 17,
              ),
            ),

            const SizedBox(
              height: 3,
            ),

            // =========================
            // BOOK COUNT
            // =========================
            Text(
              '${category.formattedBookCount} BOOKS',

              style: const TextStyle(
                color: gold,

                fontWeight:
                    FontWeight.w600,

                fontSize: 11,

                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}