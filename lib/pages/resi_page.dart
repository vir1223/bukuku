// lib/pages/resi_page.dart

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class ResiPage extends StatelessWidget {
  final Transaction transaction;
  const ResiPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Struk Belanja'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Waktu: ${DateFormat('dd-MM-yyyy HH:mm').format(transaction.date)}', style: const TextStyle(fontSize: 16)),
            const Divider(),
            const Text('Detail Barang:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: transaction.items.length,
                itemBuilder: (context, index) {
                  final item = transaction.items[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text('${item.book.title} (${item.quantity}x)')),
                      Text(currencyFormatter.format(item.book.price * item.quantity)),
                    ],
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                  currencyFormatter.format(transaction.totalPrice),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Struk dicetak... (fitur cetak sesungguhnya butuh implementasi lebih lanjut)', textAlign: TextAlign.center,),behavior: SnackBarBehavior.floating,),
                  );
                },
                icon: const Icon(Icons.print),
                label: const Text('Cetak Resi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}