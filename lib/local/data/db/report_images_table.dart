import 'package:drift/drift.dart';

class ReportImages extends Table {
  TextColumn get id => text()(); // uuid
  TextColumn get reportId => text()(); // foreign key
  TextColumn get path => text()();
  TextColumn get caption => text().nullable()();
  IntColumn get position => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
