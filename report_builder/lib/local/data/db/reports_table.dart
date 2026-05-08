import 'package:drift/drift.dart';

class Reports extends Table {
  TextColumn get id => text()(); // uuid
  TextColumn get title => text().nullable()();
  TextColumn get comment => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastModifiedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
