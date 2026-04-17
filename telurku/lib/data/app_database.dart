import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart'; // di-generate oleh build_runner

// Definisi tabel
class AktivitasTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tipe => text()(); // 'panen' | 'jual' | 'pecah'
  IntColumn get jumlah => integer()();
  DateTimeColumn get tanggal => dateTime()();
  TextColumn get catatan => text().nullable()();
  IntColumn get hargaPerButir => integer().nullable()();
}

@DriftDatabase(tables: [AktivitasTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'telurku.db'));
    return NativeDatabase.createInBackground(file);
  });
}
