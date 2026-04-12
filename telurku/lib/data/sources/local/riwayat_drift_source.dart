import 'package:drift/drift.dart';
import '../../models/riwayat_item.dart';
import '../../repositories/riwayat_repository.dart';
import '../../app_database.dart';

class RiwayatDriftSource implements RiwayatRepository {
  final AppDatabase _db;

  RiwayatDriftSource(this._db);

  RiwayatItem _toDomain(AktivitasTableData row) {
    return RiwayatItem(
      id: row.id.toString(),
      tipe: _parseTipe(row.tipe),
      jumlah: row.jumlah,
      tanggal: row.tanggal,
      catatan: row.catatan,
      hargaPerButir: row.hargaPerButir,
    );
  }

  TipeAktivitas _parseTipe(String tipe) {
    switch (tipe) {
      case 'jual':
        return TipeAktivitas.jual;
      case 'pecah':
        return TipeAktivitas.pecah;
      default:
        return TipeAktivitas.panen;
    }
  }

  @override
  Future<List<RiwayatItem>> getAll() async {
    final rows = await (_db.select(
      _db.aktivitasTable,
    )..orderBy([(t) => OrderingTerm.desc(t.tanggal)])).get();
    return rows.map(_toDomain).toList();
  }

  @override
  Future<void> tambah(RiwayatItem item) async {
    await _db
        .into(_db.aktivitasTable)
        .insert(
          AktivitasTableCompanion.insert(
            tipe: item.tipe.name,
            jumlah: item.jumlah,
            tanggal: item.tanggal,
            catatan: Value(item.catatan),
            hargaPerButir: Value(item.hargaPerButir),
          ),
        );
  }

  @override
  Future<void> hapus(String id) async {
    await (_db.delete(
      _db.aktivitasTable,
    )..where((t) => t.id.equals(int.parse(id)))).go();
  }

  // Stream opsional — untuk reaktif real-time kalau dibutuhkan nanti
  Stream<List<RiwayatItem>> watchAll() {
    return (_db.select(_db.aktivitasTable)
          ..orderBy([(t) => OrderingTerm.desc(t.tanggal)]))
        .watch()
        .map((rows) => rows.map(_toDomain).toList());
  }
}
