// lib/pages/product_page.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/book.dart';
import '../services/cart_manager.dart';
import 'cart_page.dart';
import 'package:intl/intl.dart';
import 'package:bukuku/main.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Book> _books = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    try {
      final response = await http.get(Uri.parse('https://openlibrary.org/search.json?q=novel&limit=10'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final docs = data['docs'] as List;
        _books = docs.map((doc) {
          // Hardcode harga karena API tidak menyediakan data harga
          final price = 55000.0;
          final coverId = doc['cover_i'];
          final coverUrl = coverId != null
              ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
              : 'https://via.placeholder.com/150';

          return Book(
            title: doc['title'] ?? 'Judul Tidak Diketahui',
            description: 'Oleh: ${doc['author_name']?.join(', ') ?? 'Tidak Diketahui'}',
            coverUrl: coverUrl,
            price: price,
          );
        }).toList();
      }
    } catch (e) {
      print('Gagal mengambil data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showQuantityDialog(Book book) {
    int quantity = 1;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambahkan ${book.title}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Masukkan jumlah:'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  quantity = int.tryParse(value) ?? 1;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                CartManager.addToCart(book, quantity);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${book.title} ditambahkan ke keranjang',textAlign: TextAlign.center,),behavior: SnackBarBehavior.floating,),
                );
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          book.coverUrl,
                          width: 80,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox(
                              width: 80,
                              height: 120,
                              child: Icon(Icons.book_outlined, size: 50),
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),
                              ),
                              const SizedBox(height: 4),
                              Text(book.description),
                              const SizedBox(height: 8),
                              Text(
                                currencyFormatter.format(book.price),
                                style: const TextStyle(fontWeight: FontWeight.bold, color: accentColor),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.add_shopping_cart, color: secondaryColor),
                            onPressed: () => _showQuantityDialog(book),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}