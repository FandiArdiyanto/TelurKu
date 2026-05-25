import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/riwayat_item.dart';
import '../providers/riwayat_provider.dart';
import 'custom_text_field.dart';

class FormInputSheet extends ConsumerStatefulWidget {
  final String judul;
  final IconData ikon;
  final Color warnaIkon;
  final TipeAktivitas tipe;
  final bool isJual;
  final RiwayatItem? existingItem;

  const FormInputSheet({
    super.key,
    required this.judul,
    required this.ikon,
    required this.warnaIkon,
    required this.tipe,
    this.isJual = false,
    this.existingItem,
  });

  @override
  ConsumerState<FormInputSheet> createState() => _FormInputSheetState();
}

class _FormInputSheetState extends ConsumerState<FormInputSheet> {
  final _jumlahCtrl = TextEditingController();
  final _hargaCtrl = TextEditingController();
  final _catatanCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    // Jika sedang mode edit, isi form dengan data yang sudah ada!
    if (widget.existingItem != null) {
      _jumlahCtrl.text = widget.existingItem!.jumlah.toString();
      if (widget.existingItem!.hargaPerButir != null) {
        _hargaCtrl.text = widget.existingItem!.hargaPerButir.toString();
      }
      if (widget.existingItem!.catatan != null) {
        _catatanCtrl.text = widget.existingItem!.catatan!;
      }
    }
  }
  @override
  void dispose() {
    _jumlahCtrl.dispose();
    _hargaCtrl.dispose();
    _catatanCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24, // Padding dinamis untuk keyboard
          left: 24,
          right: 24,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle / Garis kecil di atas bottom sheet
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

            // Judul Form
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.warnaIkon.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(widget.ikon, color: widget.warnaIkon, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.judul,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D3142),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Input Jumlah Telur
            TextFormField(
              controller: _jumlahCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jumlah Telur (butir)',
                filled: true,
                fillColor: const Color(0xFFF5F7FA),
                prefixIcon: Icon(Icons.numbers, color: Colors.grey[500]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) return 'Jumlah tidak boleh kosong';
                final n = int.tryParse(val.trim());
                if (n == null) return 'Masukkan angka yang valid';
                if (n <= 0) return 'Jumlah harus lebih dari 0';
                return null;
              },
            ),

            // Input Harga Jual (Khusus form penjualan)
            if (widget.isJual) ...[
              const SizedBox(height: 16),
              TextFormField(
                controller: _hargaCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Harga Jual per Butir (Rp)',
                  filled: true,
                  fillColor: const Color(0xFFF5F7FA),
                  prefixIcon: Icon(
                    Icons.payments_rounded,
                    color: Colors.grey[500],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Harga tidak boleh kosong';
                  final n = int.tryParse(val.trim());
                  if (n == null) return 'Masukkan angka yang valid';
                  if (n <= 0) return 'Harga harus lebih dari 0';
                  return null;
                },
              ),
            ],

            const SizedBox(height: 16),

            // Input Catatan (Opsional)
            CustomTextField(
              label: 'Catatan (Opsional)',
              icon: Icons.notes_rounded,
              isNumber: false,
              controller: _catatanCtrl,
            ),

            const SizedBox(height: 32),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8C00),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _loading ? null : _simpan,
                child: _loading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : const Text(
                  'Simpan Data',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) return;

    // Turunkan keyboard agar tidak menutupi animasi
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);

    try {
      final item = RiwayatItem(
        // Jika mode edit, gunakan ID lama. Jika baru, buat ID baru.
        id: widget.existingItem?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        tipe: widget.tipe,
        jumlah: int.parse(_jumlahCtrl.text.trim()),
        // Jika mode edit, pertahankan tanggal aslinya
        tanggal: widget.existingItem?.tanggal ?? DateTime.now(),
        catatan: _catatanCtrl.text.trim().isEmpty ? null : _catatanCtrl.text.trim(),
        hargaPerButir: widget.isJual ? int.parse(_hargaCtrl.text.trim()) : null,
      );

      // Cek apakah mode edit atau tambah
      if (widget.existingItem != null) {
        await ref.read(riwayatProvider.notifier).edit(item);
      } else {
        await ref.read(riwayatProvider.notifier).tambah(item);
      }

      if (mounted) {
        final messenger = ScaffoldMessenger.of(context);
        Navigator.pop(context);
        Future.delayed(const Duration(milliseconds: 300), () {
          messenger.showSnackBar(
            SnackBar(
              // Teks notifikasi menyesuaikan mode
              content: Text(widget.existingItem != null ? 'Data berhasil diubah' : '${widget.judul} berhasil disimpan'),
              backgroundColor: widget.warnaIkon,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);

        // 1. Simpan referensi messenger sebelum form ditutup
        final messenger = ScaffoldMessenger.of(context);

        // 2. Tutup form input terlebih dahulu
        Navigator.pop(context);

        // 3. Beri jeda 400ms agar animasi form turun selesai, lalu munculkan notif error
        Future.delayed(const Duration(milliseconds: 400), () {
          messenger.showSnackBar(
            SnackBar(
              content: Text(e.toString().replaceAll("Exception: ", "")),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        });
      }
    }
  }
}