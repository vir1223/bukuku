// lib/models/transaction.dart

import 'book.dart';

class Transaction {
  final String id;
  final DateTime date;
  final double totalPrice;
  final List<CartItem> items;

  Transaction({
    required this.id,
    required this.date,
    required this.totalPrice,
    required this.items,
  });
}