import 'package:flutter/material.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  // Pindahkan data dummy ke sini agar tidak dibuat ulang terus menerus
  static const List<Map<String, dynamic>> _riwayatData = [
    {
      'tipe': 'Panen',
      'jumlah': 450,
      'tanggal': '08 Apr 2026',
      'warna': Color(0xFF34C759),
      'ikon': Icons.egg_rounded,
    },
    {
      'tipe': 'Panen',
      'jumlah': 450,
      'tanggal': '08 Apr 2026',
      'warna': const Color(0xFF34C759),
      'ikon': Icons.egg_rounded,
    },
    {
      'tipe': 'Jual',
      'jumlah': 200,
      'tanggal': '07 Apr 2026',
      'warna': const Color(0xFF007AFF),
      'ikon': Icons.shopping_cart_rounded,
      'harga': 'Rp 2.500/butir',
    },
    {
      'tipe': 'Pecah',
      'jumlah': 5,
      'tanggal': '07 Apr 2026',
      'warna': const Color(0xFFFF3B30),
      'ikon': Icons.broken_image_rounded,
    },
    {
      'tipe': 'Panen',
      'jumlah': 500,
      'tanggal': '06 Apr 2026',
      'warna': const Color(0xFF34C759),
      'ikon': Icons.egg_rounded,
    },
    {
      'tipe': 'Jual',
      'jumlah': 350,
      'tanggal': '05 Apr 2026',
      'warna': const Color(0xFF007AFF),
      'ikon': Icons.shopping_cart_rounded,
      'harga': 'Rp 2.400/butir',
    },
  ];
  @override
  Widget build(BuildContext context) {
    // Data Dummy Riwayat

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Aktivitas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _riwayatData.length,
        itemBuilder: (context, index) {
          final item = _riwayatData[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: item['warna'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(item['ikon'], color: item['warna']),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['tipe'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        item['tanggal'],
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${item['jumlah']} Butir',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: item['warna'],
                      ),
                    ),
                    if (item['harga'] != null)
                      Text(
                        item['harga'],
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.blueGrey,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
