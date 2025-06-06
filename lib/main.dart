import 'package:flutter/material.dart';
import 'package:paggination_part_2/screen/product_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pagination Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue.withAlpha(50)),
        useMaterial3: true,
      ),
      home: const ProductListPage(),
    );
  }
}