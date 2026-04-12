import 'package:flutter/material.dart';

enum TipeAktivitas { panen, jual, pecah }

class RiwayatItem {
  final String id;
  final TipeAktivitas tipe;
  final int jumlah;
  final DateTime tanggal;
  final String? catatan;
  final int? hargaPerButir; // hanya untuk tipe jual

  RiwayatItem({
    required this.id,
    required this.tipe,
    required this.jumlah,
    required this.tanggal,
    this.catatan,
    this.hargaPerButir,
  });

  String get namaLabel {
    switch (tipe) {
      case TipeAktivitas.panen:
        return 'Panen';
      case TipeAktivitas.jual:
        return 'Jual';
      case TipeAktivitas.pecah:
        return 'Pecah';
    }
  }

  Color get warna {
    switch (tipe) {
      case TipeAktivitas.panen:
        return const Color(0xFF34C759);
      case TipeAktivitas.jual:
        return const Color(0xFF007AFF);
      case TipeAktivitas.pecah:
        return const Color(0xFFFF3B30);
    }
  }

  IconData get ikon {
    switch (tipe) {
      case TipeAktivitas.panen:
        return Icons.egg_rounded;
      case TipeAktivitas.jual:
        return Icons.shopping_cart_rounded;
      case TipeAktivitas.pecah:
        return Icons.broken_image_rounded;
    }
  }
}
