// lib/models/book.dart

class Book {
  final String title;
  final String description;
  final String coverUrl;
  final double price;

  Book({
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.price,
  });
}

class CartItem {
  final Book book;
  int quantity;

  CartItem({required this.book, required this.quantity});
}