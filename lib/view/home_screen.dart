import 'package:flutter/material.dart';
import 'package:library_onlile/provider/categories_provider.dart';
import 'package:library_onlile/view/notification_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, size: 30, color: Color(0xFF0F5555)),
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
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blueAccent,
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1asgec2wxVurJ2gc-nthRQUFWEFOjROLv1aWsw9i9pDizW9mgOtPaRBY&s=10",
                ),
              ),
            ),
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
                "Good Morning",
                style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "What are we researching today?",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  context.read<HomeProvider>().searchBook(value);
                },
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 247, 247, 247),
                  filled: true,
                  prefixIcon: Icon(Icons.search_off_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Search by title, author, or ISBN...",
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Browse by Genre",
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<HomeProvider>().filterCategory("All");
                      Get.to(() => const CategoriesScreen());
                    },
                    child: Text(
                      "SEE ALL",
                      style: TextStyle(fontSize: 18, color: Color(0xFF0F5555)),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: genre.length,
                  itemBuilder: (context, index) {
                    final categoryName = genre[index];
                    final isSelected =
                        homeProvider.selectedCategory == categoryName;
                    return GestureDetector(
                      onTap: () {
                        context.read<HomeProvider>().filterCategory(
                          categoryName,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsetsGeometry.only(
                          right: 15,
                          top: 12,
                          bottom: 12,
                        ),
                        child: Container(
                          width: 130,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF0F5555)
                                : const Color.fromARGB(255, 200, 243, 245),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "${genre[index]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Featured This Week",
                style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: homeProvider.filteredBooks.length,
                  itemBuilder: (context, index) {
                    final books = homeProvider.filteredBooks[index];
                    return Container(
                      width: 300,
                      margin: const EdgeInsets.only(right: 16),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                Image.network(
                                  books.image,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.star,
                                        color: const Color(0xFF8B6E28),
                                        size: 20,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  homeProvider.books[index].title,
                                  style: TextStyle(
                                    fontFamily: 'Time New Roman',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  homeProvider.books[index].author,
                                  style: TextStyle(
                                    fontFamily: 'Time New Roman',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommeded For You",
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "REFRESH",
                      style: TextStyle(fontSize: 18, color: Color(0xFF0F5555)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 280,
                child: ListView.builder(
                  shrinkWrap: true,

                  scrollDirection: Axis.horizontal,
                  itemCount: homeProvider.books.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 180,
                      margin: const EdgeInsets.only(right: 16),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                Image.network(
                                  homeProvider.books[index].image,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.star,
                                        color: const Color(0xFF8B6E28),
                                        size: 20,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  homeProvider.books[index].title,
                                  style: TextStyle(
                                    fontFamily: 'Times New Roman',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  homeProvider.books[index].author,
                                  style: TextStyle(
                                    fontFamily: 'Times New Roman',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              //New Arrival
              SizedBox(height: 10),
              Text(
                "New Arrivals",
                style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  
                  itemCount: homeProvider.newArraivals.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      width: 280,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(20),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(8),
                                child: Image.network(
                                  homeProvider.newArraivals[index].image,
                                  width: 75,
                                  height: 110,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  homeProvider.newArraivals[index].title,
                                  style: TextStyle(
                                    fontFamily: 'Times New Roman',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  homeProvider.newArraivals[index].author,
                                  style: TextStyle(
                                    fontFamily: 'Times New Roman',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color:
                                            homeProvider
                                                .newArraivals[index]
                                                .isAvailable
                                            ? Colors.green
                                            : Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Row(
                                      
                                      children: [
                                        Text(
                                          homeProvider
                                                  .newArraivals[index]
                                                  .isAvailable
                                              ? "Available in Library"
                                              : "Checked Out",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                homeProvider
                                                    .newArraivals[index]
                                                    .isAvailable
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          homeProvider
                                              .newArraivals[index]
                                              .category,
                                          style: TextStyle(
                                            fontFamily: 'Time New Roman',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
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
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> genre = ["Programming", "Computer","IT & Tech", "Science", ];
