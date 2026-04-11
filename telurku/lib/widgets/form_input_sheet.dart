import 'package:flutter/material.dart';
import 'custom_text_field.dart';

class FormInputSheet extends StatelessWidget {
  final String judul;
  final IconData ikon;
  final Color warnaIkon;
  final bool isJual;

  const FormInputSheet({
    super.key,
    required this.judul,
    required this.ikon,
    required this.warnaIkon,
    this.isJual = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  color: warnaIkon.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(ikon, color: warnaIkon, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                judul,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2D3142),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          CustomTextField(
            label: 'Jumlah Telur (butir)',
            icon: Icons.numbers,
            isNumber: true,
          ),
          if (isJual) ...[
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Harga Jual per Butir (Rp)',
              icon: Icons.payments_rounded,
              isNumber: true,
            ),
          ],
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Catatan (Opsional)',
            icon: Icons.notes_rounded,
            isNumber: false,
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
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Simpan Data',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
