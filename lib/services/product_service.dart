import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paggination_part_2/models/product_model.dart';

Future<List<Product>> fetchProducts(int page, int pageSize) async {
  final skip = (page - 1) * pageSize;
  final url = Uri.parse(
    'https://dummyjson.com/products?limit=$pageSize&skip=$skip&select=title,price',
  );

  final res = await http.get(url);

  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    final List products = data['products'];
    return products.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}