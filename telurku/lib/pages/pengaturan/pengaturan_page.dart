import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/profil_provider.dart';
import '../../providers/riwayat_provider.dart';
import '../../utils/app_colors.dart';

class PengaturanPage extends ConsumerStatefulWidget {
  const PengaturanPage({super.key});

  @override
  ConsumerState<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends ConsumerState<PengaturanPage> {
  final _namaPeternakanCtrl = TextEditingController();
  final _namaPemilikCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Ambil data dari provider saat halaman dibuka
    Future.microtask(() async {
      final profil = await ref.read(profilProvider.future);
      if (mounted) {
        setState(() {
          _namaPeternakanCtrl.text = profil.namaPeternakan;
          _namaPemilikCtrl.text = profil.namaPemilik;
        });
      }
    });
  }

  @override
  void dispose() {
    _namaPeternakanCtrl.dispose();
    _namaPemilikCtrl.dispose();
    super.dispose();
  }

  Future<void> _simpanProfil() async {
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    // Simpan melalui provider agar tersinkronisasi ke Beranda
    await ref.read(profilProvider.notifier).simpanProfil(
      _namaPeternakanCtrl.text.trim(),
      _namaPemilikCtrl.text.trim(),
    );

    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profil berhasil disimpan!'),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  Future<void> _konfirmasiReset() async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Reset Semua Data?', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Seluruh riwayat panen, penjualan, dan telur pecah akan dihapus permanen. Aksi ini tidak bisa dibatalkan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.pecah,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Ya, Hapus Semua'),
          ),
        ],
      ),
    );

    if (konfirmasi == true && mounted) {
      // Panggil fungsi hapusSemua dari riwayatProvider
      await ref.read(riwayatProvider.notifier).hapusSemua();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Seluruh data berhasil dihapus'),
            backgroundColor: AppColors.pecah,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Pengaturan',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- BAGIAN 1: PROFIL PETERNAKAN ---
            const Text(
              'Profil Peternakan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _namaPeternakanCtrl,
                    decoration: InputDecoration(
                      labelText: 'Nama Peternakan',
                      prefixIcon: const Icon(Icons.storefront_rounded),
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _namaPemilikCtrl,
                    decoration: InputDecoration(
                      labelText: 'Nama Pemilik / Juragan',
                      prefixIcon: const Icon(Icons.person_rounded),
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      onPressed: _isLoading ? null : _simpanProfil,
                      child: _isLoading
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white))
                          : const Text('Simpan Profil', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // --- BAGIAN 2: MANAJEMEN DATA ---
            const Text(
              'Manajemen Data',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.pecah.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.delete_forever_rounded, color: AppColors.pecah),
                ),
                title: const Text('Reset Semua Data', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Hapus seluruh riwayat telur', style: TextStyle(fontSize: 12)),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: _konfirmasiReset, // Memanggil fungsi reset fungsional
              ),
            ),
            const SizedBox(height: 32),

            // --- BAGIAN 3: TENTANG APLIKASI ---
            const Text(
              'Tentang Aplikasi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.egg_rounded, color: AppColors.primary, size: 40),
                  ),
                  const SizedBox(height: 12),
                  const Text('PrimalLog / TelurKu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text('Versi 1.0.0', style: TextStyle(color: AppColors.textDark.withValues(alpha: 0.5))),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(),
                  ),

                  const Text('Tim Pengembang:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text('1. Fandi Ardiyanto', style: TextStyle(color: AppColors.textDark.withValues(alpha: 0.7))),
                  Text('2. Daffa Atalla Bintang Saputra', style: TextStyle(color: AppColors.textDark.withValues(alpha: 0.7))),
                  Text('3. Ryan Nur Hidayat', style: TextStyle(color: AppColors.textDark.withValues(alpha: 0.7))),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}