import 'package:flutter/material.dart';
=======
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoriesProvider>().fetchCategories();
    });
  }
 
  void _onCategoryTap(CategoryModel category) {
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
