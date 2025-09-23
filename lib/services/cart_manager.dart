// lib/services/cart_manager.dart

import 'package:uuid/uuid.dart';
import '../models/book.dart';
import '../models/transaction.dart';

class CartManager {
  static List<CartItem> cartItems = [];
  static List<Transaction> transactionHistory = [];

  static void addToCart(Book book, int quantity) {
    var existingItem = cartItems.firstWhere(
      (item) => item.book.title == book.title,
      orElse: () => CartItem(book: book, quantity: 0),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity += quantity;
    } else {
      cartItems.add(CartItem(book: book, quantity: quantity));
    }
  }

  static double getCartTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item.book.price * item.quantity;
    }
    return total;
  }

  static void checkout() {
    if (cartItems.isEmpty) return;

    final newTransaction = Transaction(
      id: Uuid().v4(),
      date: DateTime.now(),
      totalPrice: getCartTotal(),
      items: List.from(cartItems),
    );

    transactionHistory.add(newTransaction);
    cartItems.clear();
  }
}