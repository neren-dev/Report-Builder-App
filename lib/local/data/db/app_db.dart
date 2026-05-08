import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:report_builder_app_mvp/local/data/db/report_dao.dart';
import 'package:report_builder_app_mvp/local/data/db/report_images_table.dart';
import 'package:report_builder_app_mvp/local/data/db/reports_table.dart';

part 'app_db.g.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});


@DriftDatabase(tables: [Reports, ReportImages], daos: [ReportDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'app.db'));
    return NativeDatabase(file);
  });
}
