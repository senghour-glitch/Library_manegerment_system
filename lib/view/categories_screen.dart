import 'package:flutter/material.dart';
import 'package:library_onlile/model/category_model.dart';
import 'package:library_onlile/view/search_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Color(0xFF0F5555)),
        title: Text(
          "Library",
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: 20,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F5555),
                ),
              ),
              Text(
                "Explore our curated collection of knowledge",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 16,
                ),
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  final category = categoriesList[index];
                  return Material(
                    clipBehavior: Clip.antiAlias,
                    elevation: 1,
                    shadowColor: Colors.black12,

                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchScreen(selectedCategory: category.title),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                  bottom: Radius.circular(12),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Image.network(
                                    categoriesList[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                categoriesList[index].title,
                                style: TextStyle(
                                  fontFamily: 'Times New Roman',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "${categoriesList[index].bookCount} BOOKS",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8B6E28),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
