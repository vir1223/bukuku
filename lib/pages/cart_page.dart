// lib/pages/cart_page.dart

import 'package:flutter/material.dart';
import '../services/cart_manager.dart';
import 'riwayat_page.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

  void _checkout() {
    CartManager.checkout();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Checkout berhasil!',textAlign: TextAlign.center,),behavior: SnackBarBehavior.floating,),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RiwayatPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
      ),
      body: CartManager.cartItems.isEmpty
          ? const Center(
              child: Text('Keranjang kosong.'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: CartManager.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = CartManager.cartItems[index];
                      return ListTile(
                        leading: Image.network(item.book.coverUrl, width: 50, height: 50),
                        title: Text(item.book.title),
                        subtitle: Text('Jumlah: ${item.quantity}'),
                        trailing: Text(currencyFormatter.format(item.book.price * item.quantity)),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Total: ${currencyFormatter.format(CartManager.getCartTotal())}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _checkout,
                          icon: const Icon(Icons.check),
                          label: const Text('Checkout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}