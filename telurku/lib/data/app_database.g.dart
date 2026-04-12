// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AktivitasTableTable extends AktivitasTable
    with TableInfo<$AktivitasTableTable, AktivitasTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AktivitasTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tipeMeta = const VerificationMeta('tipe');
  @override
  late final GeneratedColumn<String> tipe = GeneratedColumn<String>(
      'tipe', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _jumlahMeta = const VerificationMeta('jumlah');
  @override
  late final GeneratedColumn<int> jumlah = GeneratedColumn<int>(
      'jumlah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tanggalMeta =
      const VerificationMeta('tanggal');
  @override
  late final GeneratedColumn<DateTime> tanggal = GeneratedColumn<DateTime>(
      'tanggal', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _catatanMeta =
      const VerificationMeta('catatan');
  @override
  late final GeneratedColumn<String> catatan = GeneratedColumn<String>(
      'catatan', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _hargaPerButirMeta =
      const VerificationMeta('hargaPerButir');
  @override
  late final GeneratedColumn<int> hargaPerButir = GeneratedColumn<int>(
      'harga_per_butir', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, tipe, jumlah, tanggal, catatan, hargaPerButir];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'aktivitas_table';
  @override
  VerificationContext validateIntegrity(Insertable<AktivitasTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tipe')) {
      context.handle(
          _tipeMeta, tipe.isAcceptableOrUnknown(data['tipe']!, _tipeMeta));
    } else if (isInserting) {
      context.missing(_tipeMeta);
    }
    if (data.containsKey('jumlah')) {
      context.handle(_jumlahMeta,
          jumlah.isAcceptableOrUnknown(data['jumlah']!, _jumlahMeta));
    } else if (isInserting) {
      context.missing(_jumlahMeta);
    }
    if (data.containsKey('tanggal')) {
      context.handle(_tanggalMeta,
          tanggal.isAcceptableOrUnknown(data['tanggal']!, _tanggalMeta));
    } else if (isInserting) {
      context.missing(_tanggalMeta);
    }
    if (data.containsKey('catatan')) {
      context.handle(_catatanMeta,
          catatan.isAcceptableOrUnknown(data['catatan']!, _catatanMeta));
    }
    if (data.containsKey('harga_per_butir')) {
      context.handle(
          _hargaPerButirMeta,
          hargaPerButir.isAcceptableOrUnknown(
              data['harga_per_butir']!, _hargaPerButirMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AktivitasTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AktivitasTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tipe: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipe'])!,
      jumlah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}jumlah'])!,
      tanggal: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}tanggal'])!,
      catatan: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}catatan']),
      hargaPerButir: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}harga_per_butir']),
    );
  }

  @override
  $AktivitasTableTable createAlias(String alias) {
    return $AktivitasTableTable(attachedDatabase, alias);
  }
}

class AktivitasTableData extends DataClass
    implements Insertable<AktivitasTableData> {
  final int id;
  final String tipe;
  final int jumlah;
  final DateTime tanggal;
  final String? catatan;
  final int? hargaPerButir;
  const AktivitasTableData(
      {required this.id,
      required this.tipe,
      required this.jumlah,
      required this.tanggal,
      this.catatan,
      this.hargaPerButir});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tipe'] = Variable<String>(tipe);
    map['jumlah'] = Variable<int>(jumlah);
    map['tanggal'] = Variable<DateTime>(tanggal);
    if (!nullToAbsent || catatan != null) {
      map['catatan'] = Variable<String>(catatan);
    }
    if (!nullToAbsent || hargaPerButir != null) {
      map['harga_per_butir'] = Variable<int>(hargaPerButir);
    }
    return map;
  }

  AktivitasTableCompanion toCompanion(bool nullToAbsent) {
    return AktivitasTableCompanion(
      id: Value(id),
      tipe: Value(tipe),
      jumlah: Value(jumlah),
      tanggal: Value(tanggal),
      catatan: catatan == null && nullToAbsent
          ? const Value.absent()
          : Value(catatan),
      hargaPerButir: hargaPerButir == null && nullToAbsent
          ? const Value.absent()
          : Value(hargaPerButir),
    );
  }

  factory AktivitasTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AktivitasTableData(
      id: serializer.fromJson<int>(json['id']),
      tipe: serializer.fromJson<String>(json['tipe']),
      jumlah: serializer.fromJson<int>(json['jumlah']),
      tanggal: serializer.fromJson<DateTime>(json['tanggal']),
      catatan: serializer.fromJson<String?>(json['catatan']),
      hargaPerButir: serializer.fromJson<int?>(json['hargaPerButir']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tipe': serializer.toJson<String>(tipe),
      'jumlah': serializer.toJson<int>(jumlah),
      'tanggal': serializer.toJson<DateTime>(tanggal),
      'catatan': serializer.toJson<String?>(catatan),
      'hargaPerButir': serializer.toJson<int?>(hargaPerButir),
    };
  }

  AktivitasTableData copyWith(
          {int? id,
          String? tipe,
          int? jumlah,
          DateTime? tanggal,
          Value<String?> catatan = const Value.absent(),
          Value<int?> hargaPerButir = const Value.absent()}) =>
      AktivitasTableData(
        id: id ?? this.id,
        tipe: tipe ?? this.tipe,
        jumlah: jumlah ?? this.jumlah,
        tanggal: tanggal ?? this.tanggal,
        catatan: catatan.present ? catatan.value : this.catatan,
        hargaPerButir:
            hargaPerButir.present ? hargaPerButir.value : this.hargaPerButir,
      );
  @override
  String toString() {
    return (StringBuffer('AktivitasTableData(')
          ..write('id: $id, ')
          ..write('tipe: $tipe, ')
          ..write('jumlah: $jumlah, ')
          ..write('tanggal: $tanggal, ')
          ..write('catatan: $catatan, ')
          ..write('hargaPerButir: $hargaPerButir')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tipe, jumlah, tanggal, catatan, hargaPerButir);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AktivitasTableData &&
          other.id == this.id &&
          other.tipe == this.tipe &&
          other.jumlah == this.jumlah &&
          other.tanggal == this.tanggal &&
          other.catatan == this.catatan &&
          other.hargaPerButir == this.hargaPerButir);
}

class AktivitasTableCompanion extends UpdateCompanion<AktivitasTableData> {
  final Value<int> id;
  final Value<String> tipe;
  final Value<int> jumlah;
  final Value<DateTime> tanggal;
  final Value<String?> catatan;
  final Value<int?> hargaPerButir;
  const AktivitasTableCompanion({
    this.id = const Value.absent(),
    this.tipe = const Value.absent(),
    this.jumlah = const Value.absent(),
    this.tanggal = const Value.absent(),
    this.catatan = const Value.absent(),
    this.hargaPerButir = const Value.absent(),
  });
  AktivitasTableCompanion.insert({
    this.id = const Value.absent(),
    required String tipe,
    required int jumlah,
    required DateTime tanggal,
    this.catatan = const Value.absent(),
    this.hargaPerButir = const Value.absent(),
  })  : tipe = Value(tipe),
        jumlah = Value(jumlah),
        tanggal = Value(tanggal);
  static Insertable<AktivitasTableData> custom({
    Expression<int>? id,
    Expression<String>? tipe,
    Expression<int>? jumlah,
    Expression<DateTime>? tanggal,
    Expression<String>? catatan,
    Expression<int>? hargaPerButir,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tipe != null) 'tipe': tipe,
      if (jumlah != null) 'jumlah': jumlah,
      if (tanggal != null) 'tanggal': tanggal,
      if (catatan != null) 'catatan': catatan,
      if (hargaPerButir != null) 'harga_per_butir': hargaPerButir,
    });
  }

  AktivitasTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? tipe,
      Value<int>? jumlah,
      Value<DateTime>? tanggal,
      Value<String?>? catatan,
      Value<int?>? hargaPerButir}) {
    return AktivitasTableCompanion(
      id: id ?? this.id,
      tipe: tipe ?? this.tipe,
      jumlah: jumlah ?? this.jumlah,
      tanggal: tanggal ?? this.tanggal,
      catatan: catatan ?? this.catatan,
      hargaPerButir: hargaPerButir ?? this.hargaPerButir,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tipe.present) {
      map['tipe'] = Variable<String>(tipe.value);
    }
    if (jumlah.present) {
      map['jumlah'] = Variable<int>(jumlah.value);
    }
    if (tanggal.present) {
      map['tanggal'] = Variable<DateTime>(tanggal.value);
    }
    if (catatan.present) {
      map['catatan'] = Variable<String>(catatan.value);
    }
    if (hargaPerButir.present) {
      map['harga_per_butir'] = Variable<int>(hargaPerButir.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AktivitasTableCompanion(')
          ..write('id: $id, ')
          ..write('tipe: $tipe, ')
          ..write('jumlah: $jumlah, ')
          ..write('tanggal: $tanggal, ')
          ..write('catatan: $catatan, ')
          ..write('hargaPerButir: $hargaPerButir')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $AktivitasTableTable aktivitasTable = $AktivitasTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [aktivitasTable];
}

typedef $$AktivitasTableTableInsertCompanionBuilder = AktivitasTableCompanion
    Function({
  Value<int> id,
  required String tipe,
  required int jumlah,
  required DateTime tanggal,
  Value<String?> catatan,
  Value<int?> hargaPerButir,
});
typedef $$AktivitasTableTableUpdateCompanionBuilder = AktivitasTableCompanion
    Function({
  Value<int> id,
  Value<String> tipe,
  Value<int> jumlah,
  Value<DateTime> tanggal,
  Value<String?> catatan,
  Value<int?> hargaPerButir,
});

class $$AktivitasTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AktivitasTableTable,
    AktivitasTableData,
    $$AktivitasTableTableFilterComposer,
    $$AktivitasTableTableOrderingComposer,
    $$AktivitasTableTableProcessedTableManager,
    $$AktivitasTableTableInsertCompanionBuilder,
    $$AktivitasTableTableUpdateCompanionBuilder> {
  $$AktivitasTableTableTableManager(
      _$AppDatabase db, $AktivitasTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AktivitasTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AktivitasTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$AktivitasTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> tipe = const Value.absent(),
            Value<int> jumlah = const Value.absent(),
            Value<DateTime> tanggal = const Value.absent(),
            Value<String?> catatan = const Value.absent(),
            Value<int?> hargaPerButir = const Value.absent(),
          }) =>
              AktivitasTableCompanion(
            id: id,
            tipe: tipe,
            jumlah: jumlah,
            tanggal: tanggal,
            catatan: catatan,
            hargaPerButir: hargaPerButir,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String tipe,
            required int jumlah,
            required DateTime tanggal,
            Value<String?> catatan = const Value.absent(),
            Value<int?> hargaPerButir = const Value.absent(),
          }) =>
              AktivitasTableCompanion.insert(
            id: id,
            tipe: tipe,
            jumlah: jumlah,
            tanggal: tanggal,
            catatan: catatan,
            hargaPerButir: hargaPerButir,
          ),
        ));
}

class $$AktivitasTableTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $AktivitasTableTable,
    AktivitasTableData,
    $$AktivitasTableTableFilterComposer,
    $$AktivitasTableTableOrderingComposer,
    $$AktivitasTableTableProcessedTableManager,
    $$AktivitasTableTableInsertCompanionBuilder,
    $$AktivitasTableTableUpdateCompanionBuilder> {
  $$AktivitasTableTableProcessedTableManager(super.$state);
}

class $$AktivitasTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AktivitasTableTable> {
  $$AktivitasTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tipe => $state.composableBuilder(
      column: $state.table.tipe,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get jumlah => $state.composableBuilder(
      column: $state.table.jumlah,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get tanggal => $state.composableBuilder(
      column: $state.table.tanggal,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get catatan => $state.composableBuilder(
      column: $state.table.catatan,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get hargaPerButir => $state.composableBuilder(
      column: $state.table.hargaPerButir,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AktivitasTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AktivitasTableTable> {
  $$AktivitasTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tipe => $state.composableBuilder(
      column: $state.table.tipe,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get jumlah => $state.composableBuilder(
      column: $state.table.jumlah,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get tanggal => $state.composableBuilder(
      column: $state.table.tanggal,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get catatan => $state.composableBuilder(
      column: $state.table.catatan,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get hargaPerButir => $state.composableBuilder(
      column: $state.table.hargaPerButir,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$AktivitasTableTableTableManager get aktivitasTable =>
      $$AktivitasTableTableTableManager(_db, _db.aktivitasTable);
}
