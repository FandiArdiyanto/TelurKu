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

  const FormInputSheet({
    super.key,
    required this.judul,
    required this.ikon,
    required this.warnaIkon,
    required this.tipe,
    this.isJual = false,
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
  void dispose() {
    _jumlahCtrl.dispose();
    _hargaCtrl.dispose();
    _catatanCtrl.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);

    final item = RiwayatItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      tipe: widget.tipe,
      jumlah: int.parse(_jumlahCtrl.text.trim()),
      tanggal: DateTime.now(),
      catatan: _catatanCtrl.text.trim().isEmpty
          ? null
          : _catatanCtrl.text.trim(),
      hargaPerButir: widget.isJual ? int.parse(_hargaCtrl.text.trim()) : null,
    );

    await ref.read(riwayatProvider.notifier).tambah(item);

    if (mounted) {
      setState(() => _loading = false);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.judul} berhasil disimpan'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: widget.warnaIkon,
        ),
      );
    }
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
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          left: 24,
          right: 24,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                if (val == null || val.trim().isEmpty)
                  return 'Jumlah tidak boleh kosong';
                final n = int.tryParse(val.trim());
                if (n == null) return 'Masukkan angka yang valid';
                if (n <= 0) return 'Jumlah harus lebih dari 0';
                return null;
              },
            ),
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
                  if (val == null || val.trim().isEmpty)
                    return 'Harga tidak boleh kosong';
                  final n = int.tryParse(val.trim());
                  if (n == null) return 'Masukkan angka yang valid';
                  if (n <= 0) return 'Harga harus lebih dari 0';
                  return null;
                },
              ),
            ],
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Catatan (Opsional)',
              icon: Icons.notes_rounded,
              isNumber: false,
              controller: _catatanCtrl,
            ),
            const SizedBox(height: 32),
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
}
