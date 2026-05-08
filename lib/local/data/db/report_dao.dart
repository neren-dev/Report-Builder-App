import 'package:drift/drift.dart';
import 'package:report_builder_app_mvp/features/report/state/sort_notifier.dart';
import 'package:report_builder_app_mvp/local/data/db/app_db.dart';
import 'package:report_builder_app_mvp/local/data/db/report_images_table.dart';
import 'package:report_builder_app_mvp/local/data/db/reports_table.dart';

part 'report_dao.g.dart';

@DriftAccessor(tables: [Reports, ReportImages])
class ReportDao extends DatabaseAccessor<AppDatabase> with _$ReportDaoMixin {
  ReportDao(super.db);

  /// GET ALL REPORTS (with images)
  Future<List<(Report, List<ReportImage>)>> getReportsWithImages() async {
    final reportRows = await select(reports).get();

    List<(Report, List<ReportImage>)> result = [];

    for (final r in reportRows) {
      final imgs =
          await (select(reportImages)
                ..where((tbl) => tbl.reportId.equals(r.id))
                ..orderBy([(e) => OrderingTerm(expression: e.position)]))
              .get();

      result.add((r, imgs));
    }

    return result;
  }

  /// DELETE REPORT
  Future<void> deleteReport(String reportId) async {
    await transaction(() async {
      await (delete(
        reportImages,
      )..where((tbl) => tbl.reportId.equals(reportId))).go();

      await (delete(reports)..where((tbl) => tbl.id.equals(reportId))).go();
    });
  }

  Future<void> upsertFullReport(
    ReportsCompanion report,
    List<ReportImagesCompanion> images,
  ) async {
    await transaction(() async {
      /// UPSERT REPORT
      await into(reports).insert(
        report,
        onConflict: DoUpdate(
          (old) => report.copyWith(lastModifiedAt: Value(DateTime.now())),
        ),
      );

      /// HANDLE IMAGES SMARTLY

      final reportId = report.id.value;

      /// get existing image ids
      final existing = await (select(
        reportImages,
      )..where((t) => t.reportId.equals(reportId))).get();

      final existingIds = existing.map((e) => e.id).toSet();
      final newIds = images.map((e) => e.id.value).toSet();

      /// DELETE removed images
      final toDelete = existingIds.difference(newIds);

      if (toDelete.isNotEmpty) {
        await (delete(reportImages)..where((t) => t.id.isIn(toDelete))).go();
      }

      /// UPSERT images
      for (final img in images) {
        await into(reportImages).insert(img, onConflict: DoUpdate((_) => img));
      }
    });
  }

  Stream<List<(Report, List<ReportImage>)>> watchReportsWithImages(
    SortBy sortBy,
  ) {
    final query = select(reports).join([
      leftOuterJoin(reportImages, reportImages.reportId.equalsExp(reports.id)),
    ]);

    final order = <OrderingTerm>[];
    switch (sortBy) {
      case SortBy.lastModifiedDesc:
        order.add(OrderingTerm.desc(reports.lastModifiedAt));
        break;

      case SortBy.lastModifiedAsc:
        order.add(OrderingTerm.asc(reports.lastModifiedAt));
        break;

      case SortBy.createdAtAsc:
        order.add(OrderingTerm.asc(reports.createdAt));
        break;

      case SortBy.createdAtDesc:
        order.add(OrderingTerm.desc(reports.createdAt));
        break;
    }

    // fallback
    order.add(OrderingTerm.desc(reports.createdAt));

    final ordering = <OrderingTerm>[
      ...order, // report sorting FIRST
      OrderingTerm(expression: reportImages.position), // THEN image order
    ];

    query.orderBy(ordering);
    return query.watch().map((rows) {
      final map = <String, (Report, List<ReportImage>)>{};

      for (final row in rows) {
        final report = row.readTable(reports);
        final image = row.readTableOrNull(reportImages);

        if (!map.containsKey(report.id)) {
          map[report.id] = (report, []);
        }

        if (image != null) {
          map[report.id]!.$2.add(image);
        }
      }

      for (final entry in map.values) {
        entry.$2.sort((a, b) => a.position.compareTo(b.position));
      }

      return map.values.toList();
    });
  }
}
