import '../../models/riwayat_item.dart';
import '../../repositories/riwayat_repository.dart';

class RiwayatMemorySource implements RiwayatRepository {
  final List<RiwayatItem> _data = [];

  @override
  Future<List<RiwayatItem>> getAll() async {
    final sorted = List<RiwayatItem>.from(_data);
    sorted.sort((a, b) => b.tanggal.compareTo(a.tanggal));
    return sorted;
  }

  @override
  Future<void> tambah(RiwayatItem item) async {
    _data.add(item);
  }

  @override
  Future<void> hapus(String id) async {
    _data.removeWhere((item) => item.id == id);
  }
}
