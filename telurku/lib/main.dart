import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format mata uang & tanggal

void main() {
  runApp(const TelurKuApp());
}

class TelurKuApp extends StatelessWidget {
  const TelurKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TelurKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF8C00)),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}

// Navigasi Utama (Bottom Navbar)
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const BerandaPage(),
    const RiwayatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: const Color(0xFFFF8C00),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Beranda'),
            BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: 'Riwayat'),
          ],
        ),
      ),
    );
  }
}

// HALAMAN BERANDA
class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  void _tampilkanFormInput(BuildContext context, String judul, IconData ikon, Color warnaIkon, {bool isJual = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          left: 24,
          right: 24,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: warnaIkon.withOpacity(0.1), shape: BoxShape.circle), child: Icon(ikon, color: warnaIkon, size: 24)),
                const SizedBox(width: 12),
                Text(judul, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF2D3142))),
              ],
            ),
            const SizedBox(height: 24),
            _buildCustomTextField(label: 'Jumlah Telur (butir)', icon: Icons.numbers, isNumber: true),

            // INPUT HARGA JUAL (Hanya muncul jika judulnya Penjualan)
            if (isJual) ...[
              const SizedBox(height: 16),
              _buildCustomTextField(label: 'Harga Jual per Butir (Rp)', icon: Icons.payments_rounded, isNumber: true),
            ],

            const SizedBox(height: 16),
            _buildCustomTextField(label: 'Catatan (Opsional)', icon: Icons.notes_rounded, isNumber: false),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF8C00), foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                onPressed: () => Navigator.pop(context),
                child: const Text('Simpan Data', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTextField({required String label, required IconData icon, required bool isNumber}) {
    return TextField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF5F7FA),
        prefixIcon: Icon(icon, color: Colors.grey[500]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }

  void _tampilkanFormExport(BuildContext context) {
    // Nilai bawaan (default) saat pop-up dibuka
    String bulanTerpilih = 'April';
    String tahunTerpilih = '2026';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)))),
                  const SizedBox(height: 24),

                  const Row(
                    children: [
                      Icon(Icons.date_range_rounded, color: Color(0xFF2D3142)),
                      SizedBox(width: 12),
                      Text('Pilih Bulan Laporan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2D3142))),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      // Dropdown Pilihan Bulan
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          value: bulanTerpilih,
                          decoration: InputDecoration(
                            labelText: 'Bulan',
                            filled: true,
                            fillColor: const Color(0xFFF5F7FA),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          ),
                          items: ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember']
                              .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => bulanTerpilih = val);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Dropdown Pilihan Tahun
                      Expanded(
                        flex: 1,
                        child: DropdownButtonFormField<String>(
                          value: tahunTerpilih,
                          decoration: InputDecoration(
                            labelText: 'Tahun',
                            filled: true,
                            fillColor: const Color(0xFFF5F7FA),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          ),
                          items: ['2025', '2026'] // Bisa ditambah jika butuh tahun lain
                              .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => tahunTerpilih = val);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Tombol Unduh
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1D6F42), // Warna Hijau Khas Excel
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      icon: const Icon(Icons.download_rounded),
                      label: const Text('Unduh File Excel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.pop(context); // Tutup pop-up
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              content: Text('Proses mengunduh laporan $bulanTerpilih $tahunTerpilih...'),
                            )
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Halo, Juragan! 👨‍🌾', style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500)),
                    Text('Peternakan Makmur', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF2D3142))),
                  ]),
                  CircleAvatar(radius: 24, backgroundColor: Colors.orange[100], child: const Icon(Icons.person, color: Color(0xFFFF8C00))),
                ],
              ),
              const SizedBox(height: 32),
              // Hero Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFFF8C00), Color(0xFFFFB347)]),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: const Color(0xFFFF8C00).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
                ),
                child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Total Panen Hari Ini', style: TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(height: 8),
                  Text('1,250', style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900)),
                  Text('Butir Telur', style: TextStyle(color: Colors.white70, fontSize: 14)),
                ]),
              ),
              const SizedBox(height: 32),
              const Text('Pencatatan Cepat', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              _buildActionCard(context, 'Catat Panen Baru', 'Input hasil telur hari ini', Icons.add_circle_rounded, const Color(0xFF34C759), () => _tampilkanFormInput(context, 'Panen Baru', Icons.add_circle_rounded, const Color(0xFF34C759))),
              _buildActionCard(context, 'Catat Penjualan', 'Input data transaksi telur', Icons.point_of_sale_rounded, const Color(0xFF007AFF), () => _tampilkanFormInput(context, 'Penjualan', Icons.point_of_sale_rounded, const Color(0xFF007AFF), isJual: true)),
              _buildActionCard(context, 'Lapor Telur Pecah', 'Catat telur yang rusak', Icons.warning_rounded, const Color(0xFFFF3B30), () => _tampilkanFormInput(context, 'Telur Pecah', Icons.warning_rounded, const Color(0xFFFF3B30))),
              const SizedBox(height: 32), // Jarak sebelum tombol

              // TOMBOL EXPORT EXCEL
              SizedBox(
                width: double.infinity,
                height: 60,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey[300]!, width: 1.5)
                    ),
                  ),
                  icon: const Icon(Icons.description_outlined, color: Color(0xFF2D3142)),
                  label: const Text(
                      'Export Laporan ke Excel',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142))
                  ),
                  onPressed: () => _tampilkanFormExport(context),
                ),
              ),
              const SizedBox(height: 24), // Jarak bawah agar tidak terlalu mepet navbar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, String t, String s, IconData i, Color c, VoidCallback onTap) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(12),
        leading: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(i, color: c)),
        title: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(s, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}

// HALAMAN RIWAYAT
class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data Dummy Riwayat
    final List<Map<String, dynamic>> riwayatData = [
      {'tipe': 'Panen', 'jumlah': 450, 'tanggal': '08 Apr 2026', 'warna': const Color(0xFF34C759), 'ikon': Icons.egg_rounded},
      {'tipe': 'Jual', 'jumlah': 200, 'tanggal': '07 Apr 2026', 'warna': const Color(0xFF007AFF), 'ikon': Icons.shopping_cart_rounded, 'harga': 'Rp 2.500/butir'},
      {'tipe': 'Pecah', 'jumlah': 5, 'tanggal': '07 Apr 2026', 'warna': const Color(0xFFFF3B30), 'ikon': Icons.broken_image_rounded},
      {'tipe': 'Panen', 'jumlah': 500, 'tanggal': '06 Apr 2026', 'warna': const Color(0xFF34C759), 'ikon': Icons.egg_rounded},
      {'tipe': 'Jual', 'jumlah': 350, 'tanggal': '05 Apr 2026', 'warna': const Color(0xFF007AFF), 'ikon': Icons.shopping_cart_rounded, 'harga': 'Rp 2.400/butir'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Aktivitas', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: riwayatData.length,
        itemBuilder: (context, index) {
          final item = riwayatData[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: item['warna'].withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
                  child: Icon(item['ikon'], color: item['warna']),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(item['tipe'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(item['tanggal'], style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                  ]),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text('${item['jumlah']} Butir', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: item['warna'])),
                  if (item['harga'] != null) Text(item['harga'], style: const TextStyle(fontSize: 10, color: Colors.blueGrey)),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }
}