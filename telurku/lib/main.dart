import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart'; // 1. Tambah import ini
import 'app/app.dart';

void main() async {
  // 2. Tambah async
  // 3. Tambah inisialisasi ini
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null).then((_) {
    runApp(const ProviderScope(child: PrimalLogApp()));
  });
}
