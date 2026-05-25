import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/riwayat_item.dart'; // Dibutuhkan untuk TipeAktivitas
import '../../providers/riwayat_provider.dart';
import '../../utils/formatter.dart';
import '../../utils/app_colors.dart';
import '../../widgets/form_input_sheet.dart'; // Dibutuhkan untuk memanggil form edit

class RiwayatPage extends ConsumerStatefulWidget {
  const RiwayatPage({super.key});

  @override
  ConsumerState<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends ConsumerState<RiwayatPage> {
  late int _selectedMonth;
  late int _selectedYear;

  static const _bulanList = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  @override
  void initState() {
    super.initState();
    // Secara default, tampilkan data di bulan dan tahun saat ini
    final now = DateTime.now();
    _selectedMonth = now.month;
    _selectedYear = now.year;
  }

  @override
  Widget build(BuildContext context) {
    final asyncRiwayat = ref.watch(riwayatProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Riwayat Aktivitas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // --- HEADER FILTER BULAN & TAHUN ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.date_range_rounded, color: AppColors.textDark.withValues(alpha: 0.5)),
                const SizedBox(width: 12),
                // Dropdown Bulan
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField<int>(
                    value: _selectedMonth,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: List.generate(12, (index) {
                      return DropdownMenuItem(
                        value: index + 1,
                        child: Text(_bulanList[index], style: const TextStyle(fontSize: 14)),
                      );
                    }),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedMonth = val);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                // Dropdown Tahun
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<int>(
                    value: _selectedYear,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    // Menampilkan 3 tahun terakhir hingga tahun saat ini
                    items: [DateTime.now().year - 2, DateTime.now().year - 1, DateTime.now().year].map((tahun) {
                      return DropdownMenuItem(
                        value: tahun,
                        child: Text(tahun.toString(), style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedYear = val);
                    },
                  ),
                ),
              ],
            ),
          ),

          // --- LIST RIWAYAT ---
          Expanded(
            child: asyncRiwayat.when(
              loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (semuaRiwayat) {
                // Proses Filter Data
                final riwayatFiltered = semuaRiwayat.where((item) {
                  return item.tanggal.month == _selectedMonth &&
                      item.tanggal.year == _selectedYear;
                }).toList();

                if (riwayatFiltered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.inbox_rounded, size: 64, color: AppColors.textDark.withValues(alpha: 0.3)),
                        const SizedBox(height: 12),
                        Text(
                          'Belum ada aktivitas di ${_bulanList[_selectedMonth - 1]} $_selectedYear',
                          style: TextStyle(color: AppColors.textDark.withValues(alpha: 0.5)),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: riwayatFiltered.length,
                  itemBuilder: (context, index) {
                    final item = riwayatFiltered[index];
                    return Dismissible(
                      key: Key(item.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppColors.pecah,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.delete_rounded, color: Colors.white),
                      ),
                      confirmDismiss: (_) async {
                        bool hapus = false;
                        await showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            title: const Text(
                              'Hapus Data?',
                              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark),
                            ),
                            content: Text('Data "${item.namaLabel}" akan dihapus permanen.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  hapus = false;
                                  Navigator.pop(ctx);
                                },
                                child: Text('Batal', style: TextStyle(color: AppColors.textDark.withValues(alpha: 0.6))),
                              ),
                              TextButton(
                                onPressed: () {
                                  hapus = true;
                                  Navigator.pop(ctx);
                                },
                                child: const Text('Hapus', style: TextStyle(color: AppColors.pecah)),
                              ),
                            ],
                          ),
                        );
                        return hapus;
                      },
                      onDismissed: (_) {
                        ref.read(riwayatProvider.notifier).hapus(item.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Data berhasil dihapus'),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: AppColors.textDark,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      },
                      // KARTU DATA (Bisa di-tap untuk edit)
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              // Tampilkan form edit saat kartu ditekan
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => FormInputSheet(
                                  judul: item.tipe == TipeAktivitas.panen
                                      ? 'Edit Panen'
                                      : (item.tipe == TipeAktivitas.jual ? 'Edit Penjualan' : 'Edit Telur Pecah'),
                                  ikon: item.ikon,
                                  warnaIkon: item.warna,
                                  tipe: item.tipe,
                                  isJual: item.tipe == TipeAktivitas.jual,
                                  existingItem: item, // Mengirim data lama ke dalam form
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: item.warna.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Icon(item.ikon, color: item.warna),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.namaLabel,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark),
                                        ),
                                        Text(
                                          Formatter.date(item.tanggal),
                                          style: TextStyle(color: AppColors.textDark.withValues(alpha: 0.5), fontSize: 12),
                                        ),
                                        if (item.catatan != null)
                                          Text(
                                            item.catatan!,
                                            style: TextStyle(color: AppColors.textDark.withValues(alpha: 0.4), fontSize: 11),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${item.jumlah} Butir',
                                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: item.warna),
                                      ),
                                      if (item.hargaPerButir != null)
                                        Text(
                                          Formatter.currency(item.hargaPerButir!),
                                          style: TextStyle(fontSize: 10, color: AppColors.textDark.withValues(alpha: 0.5)),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}