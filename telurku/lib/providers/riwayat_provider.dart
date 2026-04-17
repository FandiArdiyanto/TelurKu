import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/app_database.dart';
import '../data/models/riwayat_item.dart';
import '../data/sources/local/riwayat_drift_source.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final driftSourceProvider = Provider<RiwayatDriftSource>((ref) {
  return RiwayatDriftSource(ref.read(appDatabaseProvider));
});

class RiwayatNotifier extends AsyncNotifier<List<RiwayatItem>> {
  @override
  Future<List<RiwayatItem>> build() async {
    return ref.read(driftSourceProvider).getAll();
  }

  Future<void> tambah(RiwayatItem item) async {
    await ref.read(driftSourceProvider).tambah(item);
    state = AsyncData(await ref.read(driftSourceProvider).getAll());
  }

  Future<void> hapus(String id) async {
    await ref.read(driftSourceProvider).hapus(id);
    state = AsyncData(await ref.read(driftSourceProvider).getAll());
  }
}

final riwayatProvider =
    AsyncNotifierProvider<RiwayatNotifier, List<RiwayatItem>>(
      RiwayatNotifier.new,
    );

final totalPanenHariIniProvider = Provider<int>((ref) {
  final list = ref.watch(riwayatProvider).valueOrNull ?? [];
  final today = DateTime.now();
  return list
      .where(
        (item) =>
            item.tipe == TipeAktivitas.panen &&
            item.tanggal.year == today.year &&
            item.tanggal.month == today.month &&
            item.tanggal.day == today.day,
      )
      .fold(0, (sum, item) => sum + item.jumlah);
});

final stokSisaProvider = Provider<int>((ref) {
  final list = ref.watch(riwayatProvider).valueOrNull ?? [];
  int stok = 0;
  for (final item in list) {
    if (item.tipe == TipeAktivitas.panen) stok += item.jumlah;
    if (item.tipe == TipeAktivitas.jual) stok -= item.jumlah;
    if (item.tipe == TipeAktivitas.pecah) stok -= item.jumlah;
  }
  return stok < 0 ? 0 : stok;
});
