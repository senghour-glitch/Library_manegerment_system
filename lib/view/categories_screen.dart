import 'package:flutter/material.dart';
import 'package:library_onlile/model/categories_model.dart';
import 'package:library_onlile/provider/categories_provider.dart';
import 'package:library_onlile/view/bookdetails_screen.dart';
import 'package:provider/provider.dart';

 
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
 
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}
 
class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    // Kick off the fetch once, right after the first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoriesProvider>().fetchCategories();
    });
  }
 
  void _onCategoryTap(CategoryModel category) {
    // Pushes to the book details screen. Swap the mock book passed here
    // for a real lookup (e.g. fetch the first/featured book in this
    // category) once your books API/repository is wired up.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookDetailsScreen(category: category),
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF16414B);
    const gold = Color(0xFF8A6D3B);
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
            icon: const Icon(Icons.search, color: teal),
            onPressed: () {
              // TODO: hook up search
            },
          ),
        ],
      ),
      body: Consumer<CategoriesProvider>(
        builder: (context, provider, _) {
          switch (provider.status) {
            case CategoriesStatus.initial:
            case CategoriesStatus.loading:
              return const Center(child: CircularProgressIndicator(color: teal));
 
            case CategoriesStatus.error:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Something went wrong.\n${provider.errorMessage ?? ''}',
                        textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => provider.fetchCategories(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
 
            case CategoriesStatus.loaded:
              return RefreshIndicator(
                onRefresh: provider.fetchCategories,
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Categories',
                              style: TextStyle(
                                color: teal,
                                fontFamily: 'Serif',
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Explore our curated collection of knowledge.',
                              style: TextStyle(color: Colors.black54, fontSize: 15),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.78,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final category = provider.categories[index];
                            return _CategoryCard(
                              category: category,
                              onTap: () => _onCategoryTap(category),
                            );
                          },
                          childCount: provider.categories.length,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
 
class _CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;
 
  const _CategoryCard({required this.category, required this.onTap});
 
  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF16414B);
    const gold = Color(0xFF8A6D3B);
 
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
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
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  category.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(color: Colors.grey.shade200);
                  },
                  errorBuilder: (context, error, stack) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported_outlined,
                        color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              category.title,
              style: const TextStyle(
                color: teal,
                fontFamily: 'Serif',
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${category.formattedBookCount} BOOKS',
              style: const TextStyle(
                color: gold,
                fontWeight: FontWeight.w600,
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
 