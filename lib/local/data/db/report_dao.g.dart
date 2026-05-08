// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_dao.dart';

// ignore_for_file: type=lint
mixin _$ReportDaoMixin on DatabaseAccessor<AppDatabase> {
  $ReportsTable get reports => attachedDatabase.reports;
  $ReportImagesTable get reportImages => attachedDatabase.reportImages;
  ReportDaoManager get managers => ReportDaoManager(this);
}

class ReportDaoManager {
  final _$ReportDaoMixin _db;
  ReportDaoManager(this._db);
  $$ReportsTableTableManager get reports =>
      $$ReportsTableTableManager(_db.attachedDatabase, _db.reports);
  $$ReportImagesTableTableManager get reportImages =>
      $$ReportImagesTableTableManager(_db.attachedDatabase, _db.reportImages);
}
