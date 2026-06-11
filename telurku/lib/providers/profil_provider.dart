import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilState {
  final String namaPeternakan;
  final String namaPemilik;

  ProfilState({required this.namaPeternakan, required this.namaPemilik});
}

class ProfilNotifier extends AsyncNotifier<ProfilState> {
  @override
  Future<ProfilState> build() async {
    final prefs = await SharedPreferences.getInstance();
    return ProfilState(
      namaPeternakan: prefs.getString('nama_peternakan') ?? 'Peternakan Makmur',
      namaPemilik: prefs.getString('nama_pemilik') ?? 'Juragan',
    );
  }

  Future<void> simpanProfil(String peternakan, String pemilik) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama_peternakan', peternakan);
    await prefs.setString('nama_pemilik', pemilik);

    // Perbarui state agar semua halaman yang memantau provider ini ikut berubah
    state = AsyncData(ProfilState(namaPeternakan: peternakan, namaPemilik: pemilik));
  }
}

final profilProvider = AsyncNotifierProvider<ProfilNotifier, ProfilState>(
  ProfilNotifier.new,
);