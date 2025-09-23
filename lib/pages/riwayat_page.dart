// lib/pages/riwayat_page.dart

import 'package:flutter/material.dart';
import '../services/cart_manager.dart';
import 'resi_page.dart';
import 'package:intl/intl.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
      ),
      body: CartManager.transactionHistory.isEmpty
          ? const Center(child: Text('Belum ada riwayat transaksi.'))
          : ListView.builder(
              itemCount: CartManager.transactionHistory.length,
              itemBuilder: (context, index) {
                final transaction = CartManager.transactionHistory[index];
                return Card(
                  child: ListTile(
                    title: Text('Transaksi pada: ${DateFormat('dd-MM-yyyy HH:mm').format(transaction.date)}'),
                    subtitle: Text('Jumlah Item: ${transaction.items.length}'),
                    trailing: Text(
                      currencyFormatter.format(transaction.totalPrice),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResiPage(transaction: transaction),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}