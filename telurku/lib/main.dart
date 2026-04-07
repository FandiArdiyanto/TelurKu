import 'package:flutter/material.dart';

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
        scaffoldBackgroundColor: const Color(0xFFF5F7FA), // Warna background abu-abu sangat muda (modern)
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF8C00)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const BerandaPage(),
    );
  }
}

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  void _tampilkanFormInput(BuildContext context, String judul, IconData ikon, Color warnaIkon) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Transparan agar bisa bikin ujung rounded sendiri
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
            // Pill indicator di atas bottom sheet
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: warnaIkon.withOpacity(0.1), shape: BoxShape.circle),
                  child: Icon(ikon, color: warnaIkon, size: 24),
                ),
                const SizedBox(width: 12),
                Text(judul, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF2D3142))),
              ],
            ),
            const SizedBox(height: 24),
            _buildCustomTextField(label: 'Jumlah Telur (butir)', icon: Icons.numbers, isNumber: true),
            const SizedBox(height: 16),
            _buildCustomTextField(label: 'Catatan (Opsional)', icon: Icons.notes_rounded, isNumber: false),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8C00),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      content: const Text('Yeay! Data berhasil disimpan 🥚'),
                    ),
                  );
                },
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
        labelStyle: TextStyle(color: Colors.grey[600]),
        filled: true,
        fillColor: const Color(0xFFF5F7FA),
        prefixIcon: Icon(icon, color: Colors.grey[500]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFF8C00), width: 2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CUSTOM HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Halo, Juragan! 👨‍🌾', style: TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w500)),
                      const SizedBox(height: 4),
                      const Text('Peternakan Makmur', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF2D3142))),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.orange[100],
                    child: const Icon(Icons.person, color: Color(0xFFFF8C00), size: 28),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // HERO CARD (Total Terkumpul) - Pakai Gradasi
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8C00), Color(0xFFFFB347)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: const Color(0xFFFF8C00).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.egg_alt, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Text('Total Panen Hari Ini', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('1,250', style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900, letterSpacing: -1)),
                    const Text('Butir Telur', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ROW STATISTIK (Pecah & Terjual)
              Row(
                children: [
                  Expanded(child: _buildMiniStatCard(judul: 'Pecah', nilai: '12', ikon: Icons.broken_image_rounded, warna: const Color(0xFFFF3B30))),
                  const SizedBox(width: 16),
                  Expanded(child: _buildMiniStatCard(judul: 'Terjual', nilai: '840', ikon: Icons.shopping_bag_rounded, warna: const Color(0xFF007AFF))),
                ],
              ),
              const SizedBox(height: 32),

              // MENU AKSI
              const Text('Pencatatan Cepat', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF2D3142))),
              const SizedBox(height: 16),

              _buildModernActionCard(
                context,
                judul: 'Catat Panen Baru',
                deskripsi: 'Input hasil telur yang baru diambil',
                ikon: Icons.add_circle_rounded,
                warna: const Color(0xFF34C759),
                onTap: () => _tampilkanFormInput(context, 'Panen Baru', Icons.add_circle_rounded, const Color(0xFF34C759)),
              ),
              _buildModernActionCard(
                context,
                judul: 'Lapor Telur Pecah',
                deskripsi: 'Catat telur yang rusak hari ini',
                ikon: Icons.warning_rounded,
                warna: const Color(0xFFFF3B30),
                onTap: () => _tampilkanFormInput(context, 'Telur Pecah', Icons.warning_rounded, const Color(0xFFFF3B30)),
              ),
              _buildModernActionCard(
                context,
                judul: 'Catat Penjualan',
                deskripsi: 'Input data telur yang laku terjual',
                ikon: Icons.point_of_sale_rounded,
                warna: const Color(0xFF007AFF),
                onTap: () => _tampilkanFormInput(context, 'Penjualan', Icons.point_of_sale_rounded, const Color(0xFF007AFF)),
              ),
              const SizedBox(height: 32),

              // TOMBOL EXPORT
              SizedBox(
                width: double.infinity,
                height: 60,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.grey[300]!, width: 1.5)),
                  ),
                  icon: const Icon(Icons.description_outlined, color: Color(0xFF2D3142)),
                  label: const Text('Export Laporan ke Excel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142))),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menyiapkan file Excel...')));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniStatCard({required String judul, required String nilai, required IconData ikon, required Color warna}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ikon, color: warna, size: 28),
          const SizedBox(height: 12),
          Text(nilai, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2D3142))),
          Text(judul, style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildModernActionCard(BuildContext context, {required String judul, required String deskripsi, required IconData ikon, required Color warna, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: warna.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
                  child: Icon(ikon, color: warna, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(judul, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2D3142))),
                      const SizedBox(height: 4),
                      Text(deskripsi, style: TextStyle(color: Colors.grey[500], fontSize: 13)),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}