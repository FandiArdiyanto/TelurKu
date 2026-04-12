import '../models/riwayat_item.dart';

abstract class RiwayatRepository {
  Future<List<RiwayatItem>> getAll();
  Future<void> tambah(RiwayatItem item);
  Future<void> hapus(String id);
}
