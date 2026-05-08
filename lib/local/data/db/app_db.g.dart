// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $ReportsTable extends Reports with TableInfo<$ReportsTable, Report> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastModifiedAtMeta = const VerificationMeta(
    'lastModifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastModifiedAt =
      GeneratedColumn<DateTime>(
        'last_modified_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    comment,
    createdAt,
    lastModifiedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<Report> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_modified_at')) {
      context.handle(
        _lastModifiedAtMeta,
        lastModifiedAt.isAcceptableOrUnknown(
          data['last_modified_at']!,
          _lastModifiedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModifiedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Report map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Report(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastModifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_modified_at'],
      )!,
    );
  }

  @override
  $ReportsTable createAlias(String alias) {
    return $ReportsTable(attachedDatabase, alias);
  }
}

class Report extends DataClass implements Insertable<Report> {
  final String id;
  final String? title;
  final String? comment;
  final DateTime createdAt;
  final DateTime lastModifiedAt;
  const Report({
    required this.id,
    this.title,
    this.comment,
    required this.createdAt,
    required this.lastModifiedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['last_modified_at'] = Variable<DateTime>(lastModifiedAt);
    return map;
  }

  ReportsCompanion toCompanion(bool nullToAbsent) {
    return ReportsCompanion(
      id: Value(id),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      createdAt: Value(createdAt),
      lastModifiedAt: Value(lastModifiedAt),
    );
  }

  factory Report.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Report(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      comment: serializer.fromJson<String?>(json['comment']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastModifiedAt: serializer.fromJson<DateTime>(json['lastModifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String?>(title),
      'comment': serializer.toJson<String?>(comment),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastModifiedAt': serializer.toJson<DateTime>(lastModifiedAt),
    };
  }

  Report copyWith({
    String? id,
    Value<String?> title = const Value.absent(),
    Value<String?> comment = const Value.absent(),
    DateTime? createdAt,
    DateTime? lastModifiedAt,
  }) => Report(
    id: id ?? this.id,
    title: title.present ? title.value : this.title,
    comment: comment.present ? comment.value : this.comment,
    createdAt: createdAt ?? this.createdAt,
    lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
  );
  Report copyWithCompanion(ReportsCompanion data) {
    return Report(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      comment: data.comment.present ? data.comment.value : this.comment,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastModifiedAt: data.lastModifiedAt.present
          ? data.lastModifiedAt.value
          : this.lastModifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Report(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('comment: $comment, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastModifiedAt: $lastModifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, comment, createdAt, lastModifiedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Report &&
          other.id == this.id &&
          other.title == this.title &&
          other.comment == this.comment &&
          other.createdAt == this.createdAt &&
          other.lastModifiedAt == this.lastModifiedAt);
}

class ReportsCompanion extends UpdateCompanion<Report> {
  final Value<String> id;
  final Value<String?> title;
  final Value<String?> comment;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastModifiedAt;
  final Value<int> rowid;
  const ReportsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.comment = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastModifiedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReportsCompanion.insert({
    required String id,
    this.title = const Value.absent(),
    this.comment = const Value.absent(),
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       lastModifiedAt = Value(lastModifiedAt);
  static Insertable<Report> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? comment,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastModifiedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (comment != null) 'comment': comment,
      if (createdAt != null) 'created_at': createdAt,
      if (lastModifiedAt != null) 'last_modified_at': lastModifiedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReportsCompanion copyWith({
    Value<String>? id,
    Value<String?>? title,
    Value<String?>? comment,
    Value<DateTime>? createdAt,
    Value<DateTime>? lastModifiedAt,
    Value<int>? rowid,
  }) {
    return ReportsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastModifiedAt.present) {
      map['last_modified_at'] = Variable<DateTime>(lastModifiedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('comment: $comment, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastModifiedAt: $lastModifiedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReportImagesTable extends ReportImages
    with TableInfo<$ReportImagesTable, ReportImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reportIdMeta = const VerificationMeta(
    'reportId',
  );
  @override
  late final GeneratedColumn<String> reportId = GeneratedColumn<String>(
    'report_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _captionMeta = const VerificationMeta(
    'caption',
  );
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, reportId, path, caption, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'report_images';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReportImage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('report_id')) {
      context.handle(
        _reportIdMeta,
        reportId.isAcceptableOrUnknown(data['report_id']!, _reportIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reportIdMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(
        _captionMeta,
        caption.isAcceptableOrUnknown(data['caption']!, _captionMeta),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReportImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReportImage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      reportId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_id'],
      )!,
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      )!,
      caption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caption'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $ReportImagesTable createAlias(String alias) {
    return $ReportImagesTable(attachedDatabase, alias);
  }
}

class ReportImage extends DataClass implements Insertable<ReportImage> {
  final String id;
  final String reportId;
  final String path;
  final String? caption;
  final int position;
  const ReportImage({
    required this.id,
    required this.reportId,
    required this.path,
    this.caption,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['report_id'] = Variable<String>(reportId);
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    map['position'] = Variable<int>(position);
    return map;
  }

  ReportImagesCompanion toCompanion(bool nullToAbsent) {
    return ReportImagesCompanion(
      id: Value(id),
      reportId: Value(reportId),
      path: Value(path),
      caption: caption == null && nullToAbsent
          ? const Value.absent()
          : Value(caption),
      position: Value(position),
    );
  }

  factory ReportImage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReportImage(
      id: serializer.fromJson<String>(json['id']),
      reportId: serializer.fromJson<String>(json['reportId']),
      path: serializer.fromJson<String>(json['path']),
      caption: serializer.fromJson<String?>(json['caption']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'reportId': serializer.toJson<String>(reportId),
      'path': serializer.toJson<String>(path),
      'caption': serializer.toJson<String?>(caption),
      'position': serializer.toJson<int>(position),
    };
  }

  ReportImage copyWith({
    String? id,
    String? reportId,
    String? path,
    Value<String?> caption = const Value.absent(),
    int? position,
  }) => ReportImage(
    id: id ?? this.id,
    reportId: reportId ?? this.reportId,
    path: path ?? this.path,
    caption: caption.present ? caption.value : this.caption,
    position: position ?? this.position,
  );
  ReportImage copyWithCompanion(ReportImagesCompanion data) {
    return ReportImage(
      id: data.id.present ? data.id.value : this.id,
      reportId: data.reportId.present ? data.reportId.value : this.reportId,
      path: data.path.present ? data.path.value : this.path,
      caption: data.caption.present ? data.caption.value : this.caption,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReportImage(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('path: $path, ')
          ..write('caption: $caption, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, reportId, path, caption, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReportImage &&
          other.id == this.id &&
          other.reportId == this.reportId &&
          other.path == this.path &&
          other.caption == this.caption &&
          other.position == this.position);
}

class ReportImagesCompanion extends UpdateCompanion<ReportImage> {
  final Value<String> id;
  final Value<String> reportId;
  final Value<String> path;
  final Value<String?> caption;
  final Value<int> position;
  final Value<int> rowid;
  const ReportImagesCompanion({
    this.id = const Value.absent(),
    this.reportId = const Value.absent(),
    this.path = const Value.absent(),
    this.caption = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReportImagesCompanion.insert({
    required String id,
    required String reportId,
    required String path,
    this.caption = const Value.absent(),
    required int position,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       reportId = Value(reportId),
       path = Value(path),
       position = Value(position);
  static Insertable<ReportImage> custom({
    Expression<String>? id,
    Expression<String>? reportId,
    Expression<String>? path,
    Expression<String>? caption,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reportId != null) 'report_id': reportId,
      if (path != null) 'path': path,
      if (caption != null) 'caption': caption,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReportImagesCompanion copyWith({
    Value<String>? id,
    Value<String>? reportId,
    Value<String>? path,
    Value<String?>? caption,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return ReportImagesCompanion(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      path: path ?? this.path,
      caption: caption ?? this.caption,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (reportId.present) {
      map['report_id'] = Variable<String>(reportId.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportImagesCompanion(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('path: $path, ')
          ..write('caption: $caption, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ReportsTable reports = $ReportsTable(this);
  late final $ReportImagesTable reportImages = $ReportImagesTable(this);
  late final ReportDao reportDao = ReportDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [reports, reportImages];
}

typedef $$ReportsTableCreateCompanionBuilder =
    ReportsCompanion Function({
      required String id,
      Value<String?> title,
      Value<String?> comment,
      required DateTime createdAt,
      required DateTime lastModifiedAt,
      Value<int> rowid,
    });
typedef $$ReportsTableUpdateCompanionBuilder =
    ReportsCompanion Function({
      Value<String> id,
      Value<String?> title,
      Value<String?> comment,
      Value<DateTime> createdAt,
      Value<DateTime> lastModifiedAt,
      Value<int> rowid,
    });

class $$ReportsTableFilterComposer
    extends Composer<_$AppDatabase, $ReportsTable> {
  $$ReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastModifiedAt => $composableBuilder(
    column: $table.lastModifiedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReportsTable> {
  $$ReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastModifiedAt => $composableBuilder(
    column: $table.lastModifiedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReportsTable> {
  $$ReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedAt => $composableBuilder(
    column: $table.lastModifiedAt,
    builder: (column) => column,
  );
}

class $$ReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReportsTable,
          Report,
          $$ReportsTableFilterComposer,
          $$ReportsTableOrderingComposer,
          $$ReportsTableAnnotationComposer,
          $$ReportsTableCreateCompanionBuilder,
          $$ReportsTableUpdateCompanionBuilder,
          (Report, BaseReferences<_$AppDatabase, $ReportsTable, Report>),
          Report,
          PrefetchHooks Function()
        > {
  $$ReportsTableTableManager(_$AppDatabase db, $ReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> lastModifiedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReportsCompanion(
                id: id,
                title: title,
                comment: comment,
                createdAt: createdAt,
                lastModifiedAt: lastModifiedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> title = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                required DateTime createdAt,
                required DateTime lastModifiedAt,
                Value<int> rowid = const Value.absent(),
              }) => ReportsCompanion.insert(
                id: id,
                title: title,
                comment: comment,
                createdAt: createdAt,
                lastModifiedAt: lastModifiedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReportsTable,
      Report,
      $$ReportsTableFilterComposer,
      $$ReportsTableOrderingComposer,
      $$ReportsTableAnnotationComposer,
      $$ReportsTableCreateCompanionBuilder,
      $$ReportsTableUpdateCompanionBuilder,
      (Report, BaseReferences<_$AppDatabase, $ReportsTable, Report>),
      Report,
      PrefetchHooks Function()
    >;
typedef $$ReportImagesTableCreateCompanionBuilder =
    ReportImagesCompanion Function({
      required String id,
      required String reportId,
      required String path,
      Value<String?> caption,
      required int position,
      Value<int> rowid,
    });
typedef $$ReportImagesTableUpdateCompanionBuilder =
    ReportImagesCompanion Function({
      Value<String> id,
      Value<String> reportId,
      Value<String> path,
      Value<String?> caption,
      Value<int> position,
      Value<int> rowid,
    });

class $$ReportImagesTableFilterComposer
    extends Composer<_$AppDatabase, $ReportImagesTable> {
  $$ReportImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportId => $composableBuilder(
    column: $table.reportId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReportImagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ReportImagesTable> {
  $$ReportImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportId => $composableBuilder(
    column: $table.reportId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReportImagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReportImagesTable> {
  $$ReportImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reportId =>
      $composableBuilder(column: $table.reportId, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);
}

class $$ReportImagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReportImagesTable,
          ReportImage,
          $$ReportImagesTableFilterComposer,
          $$ReportImagesTableOrderingComposer,
          $$ReportImagesTableAnnotationComposer,
          $$ReportImagesTableCreateCompanionBuilder,
          $$ReportImagesTableUpdateCompanionBuilder,
          (
            ReportImage,
            BaseReferences<_$AppDatabase, $ReportImagesTable, ReportImage>,
          ),
          ReportImage,
          PrefetchHooks Function()
        > {
  $$ReportImagesTableTableManager(_$AppDatabase db, $ReportImagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReportImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReportImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReportImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> reportId = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<String?> caption = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReportImagesCompanion(
                id: id,
                reportId: reportId,
                path: path,
                caption: caption,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String reportId,
                required String path,
                Value<String?> caption = const Value.absent(),
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => ReportImagesCompanion.insert(
                id: id,
                reportId: reportId,
                path: path,
                caption: caption,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReportImagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReportImagesTable,
      ReportImage,
      $$ReportImagesTableFilterComposer,
      $$ReportImagesTableOrderingComposer,
      $$ReportImagesTableAnnotationComposer,
      $$ReportImagesTableCreateCompanionBuilder,
      $$ReportImagesTableUpdateCompanionBuilder,
      (
        ReportImage,
        BaseReferences<_$AppDatabase, $ReportImagesTable, ReportImage>,
      ),
      ReportImage,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ReportsTableTableManager get reports =>
      $$ReportsTableTableManager(_db, _db.reports);
  $$ReportImagesTableTableManager get reportImages =>
      $$ReportImagesTableTableManager(_db, _db.reportImages);
}
