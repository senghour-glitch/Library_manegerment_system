import 'package:flutter/material.dart';
import 'package:library_onlile/provider/homescreen_provider.dart';
import 'package:library_onlile/wedgid_controller.dart/homescreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          "Academic Library",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              onChanged: provider.searchBook,
              decoration: InputDecoration(
                hintText: "Search books...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: provider.filteredBooks.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: .65,
                ),
                itemBuilder: (context, index) {
                  return BookCard(
                    book: provider.filteredBooks[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}