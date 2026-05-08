import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_builder_app_mvp/features/report/model/report.dart';
import 'package:report_builder_app_mvp/features/report/state/sort_notifier.dart';
import 'package:report_builder_app_mvp/local/data/db/app_db.dart' as app_db;

final reportRepoProvider = Provider<ReportRepository>((ref) {
  final db = ref.watch(app_db.databaseProvider);
  return ReportRepository(db);
});

final reportsProvider = StreamProvider<List<AppReport>>((ref) {
  final repo = ref.watch(reportRepoProvider);
  final currentSort = ref.watch(reportsListSortByProvider);
  return repo.watchReports(currentSort);
});

class ReportRepository {
  final app_db.AppDatabase db;

  ReportRepository(this.db);

  /// SAVE
  Future<void> saveReport(AppReport report) async {
    final reportCompanion = app_db.ReportsCompanion.insert(
      id: report.id,
      title: Value(report.title),
      comment: Value(report.comment),
      createdAt: report.createdAt,
      lastModifiedAt: DateTime.now(),
    );

    final images = report.images.asMap().entries.map((entry) {
      final i = entry.key;
      final img = entry.value;
      return app_db.ReportImagesCompanion.insert(
        id: img.id,
        reportId: report.id,
        path: img.path,
        caption: Value(img.caption),
        position: i,
      );
    }).toList();

    await db.reportDao.upsertFullReport(reportCompanion, images);
  }

  Stream<List<AppReport>> watchReports(SortBy sortBy) {
    return db.reportDao.watchReportsWithImages(sortBy).map((data) {
      return data.map((entry) {
        final reportRow = entry.$1;
        final imageRows = entry.$2;

        return AppReport(
          id: reportRow.id,
          title: reportRow.title ?? '',
          comment: reportRow.comment ?? '',
          createdAt: reportRow.createdAt,
          lastModifiedAt: reportRow.lastModifiedAt,
          images: imageRows
              .map(
                (e) => ReportImage(
                  id: e.id,
                  path: e.path,
                  caption: e.caption ?? '',
                ),
              )
              .toList(),
        );
      }).toList();
    });
  }

  /// GET
  Future<List<AppReport>> getReports() async {
    final data = await db.reportDao.getReportsWithImages();

    return data.map((entry) {
      final reportRow = entry.$1;
      final imageRows = entry.$2;
      imageRows.sort((a, b) => a.position.compareTo(b.position));
      return AppReport(
        id: reportRow.id,
        title: reportRow.title ?? '',
        comment: reportRow.comment ?? '',
        createdAt: reportRow.createdAt,
        lastModifiedAt: reportRow.lastModifiedAt,
        images: imageRows
            .map(
              (e) =>
                  ReportImage(id: e.id, path: e.path, caption: e.caption ?? ''),
            )
            .toList(),
      );
    }).toList();
  }

  /// DELETE
  Future<void> deleteReport(String id) {
    return db.reportDao.deleteReport(id);
  }
}
