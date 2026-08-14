import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_onlile/provider/home_screen_provider.dart';
import 'package:library_onlile/provider/search_provider.dart';
import 'package:library_onlile/view/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      
  providers: [
    ChangeNotifierProvider(create: (_) => HomeProvider()), 
    ChangeNotifierProvider(create: (_) => SearchProvider()),
  ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SearchScreen(),
      ),
    );
  }
}
