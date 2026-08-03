import 'package:flutter/material.dart';
import 'package:library_onlile/provider/splash_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SplashProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (provider.isLoading) {
        provider.startSplash(context);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF3F51B5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  "https://i.pinimg.com/736x/32/0d/9f/320d9f991e417508dc9ef46113664b03.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 25),
            const Text(
              "Smart Library",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Read • Learn • Grow",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),

            SizedBox(height: 50),
            provider.isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(
                    Icons.check_circle,
                    color: Colors.greenAccent,
                    size: 40,
                  ),
          ],
        ),
      ),
    );
  }
}
