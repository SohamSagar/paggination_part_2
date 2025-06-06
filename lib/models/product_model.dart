class Product {
  final String title;
  final num price;

  Product({required this.title, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      price: json['price'],
    );
  }
}