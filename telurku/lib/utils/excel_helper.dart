import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../data/models/riwayat_item.dart';
import 'formatter.dart';

class ExcelHelper {
  static Future<void> exportAndShare(List<RiwayatItem> data, int bulan, int tahun) async {
    // 1. Filter data berdasarkan bulan & tahun yang dipilih
    final filteredData = data.where((e) {
      return e.tanggal.month == bulan && e.tanggal.year == tahun;
    }).toList();

    if (filteredData.isEmpty) {
      throw Exception('Tidak ada data aktivitas pada bulan ini.');
    }

    // 2. Buat file Excel dan atur nama Sheet
    var excel = Excel.createExcel();
    var sheetName = 'Laporan TelurKu';
    var sheet = excel[sheetName];
    excel.setDefaultSheet(sheetName);

    // 3. Buat Header Tabel (Baris Pertama)
    sheet.appendRow([
      TextCellValue('Tanggal'),
      TextCellValue('Aktivitas'),
      TextCellValue('Jumlah (Butir)'),
      TextCellValue('Harga per Butir (Rp)'),
      TextCellValue('Total Pendapatan (Rp)'),
      TextCellValue('Catatan')
    ]);

    // --- Variabel untuk menghitung total ringkasan ---
    int totalPanen = 0;
    int totalJual = 0;
    int totalPecah = 0;
    int totalPendapatanSemua = 0;

    // 4. Isi Data ke dalam Tabel dan Hitung Total
    for (var item in filteredData) {
      String tipeString = '';

      // Hitung akumulasi berdasarkan tipe aktivitas
      if (item.tipe == TipeAktivitas.panen) {
        tipeString = 'Panen';
        totalPanen += item.jumlah;
      } else if (item.tipe == TipeAktivitas.jual) {
        tipeString = 'Jual';
        totalJual += item.jumlah;
      } else {
        tipeString = 'Pecah';
        totalPecah += item.jumlah;
      }

      int totalPendapatanBaris = (item.hargaPerButir ?? 0) * item.jumlah;

      if (item.tipe == TipeAktivitas.jual) {
        totalPendapatanSemua += totalPendapatanBaris;
      }

      sheet.appendRow([
        TextCellValue(Formatter.date(item.tanggal)),
        TextCellValue(tipeString),
        IntCellValue(item.jumlah),
        item.hargaPerButir != null ? IntCellValue(item.hargaPerButir!) : TextCellValue('-'),
        totalPendapatanBaris > 0 ? IntCellValue(totalPendapatanBaris) : TextCellValue('-'),
        TextCellValue(item.catatan ?? '-')
      ]);
    }

    // 5. Tambahkan Jeda Baris Kosong
    sheet.appendRow([TextCellValue('')]);
    sheet.appendRow([TextCellValue('')]);

    // 6. Tambahkan Bagian Ringkasan Laporan di Bawah
    sheet.appendRow([TextCellValue('RINGKASAN LAPORAN BULAN $bulan TAHUN $tahun')]);
    sheet.appendRow([TextCellValue('Total Panen'), IntCellValue(totalPanen), TextCellValue('Butir')]);
    sheet.appendRow([TextCellValue('Total Terjual'), IntCellValue(totalJual), TextCellValue('Butir')]);
    sheet.appendRow([TextCellValue('Total Telur Pecah'), IntCellValue(totalPecah), TextCellValue('Butir')]);
    sheet.appendRow([TextCellValue('Total Pendapatan'), TextCellValue(Formatter.currency(totalPendapatanSemua))]);

    // 7. Simpan file sementara di memori HP (Cache)
    var fileBytes = excel.save();
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/Laporan_TelurKu_${bulan}_$tahun.xlsx';
    File file = File(filePath);
    await file.writeAsBytes(fileBytes!);

    // 8. Tampilkan menu Share bawaan HP
    await Share.shareXFiles(
      [XFile(filePath)],
      text: 'Laporan TelurKu Bulan $bulan Tahun $tahun',
    );
  }
}