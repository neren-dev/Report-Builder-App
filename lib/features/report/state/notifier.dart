import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_builder_app_mvp/local/data/repo/db_repo.dart';
import 'package:uuid/uuid.dart';
import '../model/report.dart';

final reportProvider = NotifierProvider.family
    .autoDispose<ReportNotifier, AppReport, AppReport>(ReportNotifier.new);

class ReportNotifier extends Notifier<AppReport> {
  final AppReport report;

  ReportNotifier(this.report);

  @override
  AppReport build() {
    return report;
  }

  Future<void> save() async {
    if (state.images.isEmpty) return;
    await ref.read(reportRepoProvider).saveReport(state);
    debugPrint('Saved!!');
  }

  void setTitle(String value) {
    state = state.copyWith(title: value);
  }

  void setComment(String value) {
    state = state.copyWith(comment: value);
  }

  void addImage(String path) {
    if (state.images.length >= 4) return;

    final updated = [
      ...state.images,
      ReportImage(id: const Uuid().v4(), path: path),
    ];

    state = state.copyWith(images: updated);
  }

  void updateImage(int index, String path) {
    final updated = [...state.images];
    updated[index] = updated[index].copyWith(path: path);
    state = state.copyWith(images: updated);
  }

  void updateCaption(int index, String caption) {
    final updated = [...state.images];
    updated[index] = updated[index].copyWith(caption: caption);

    state = state.copyWith(images: updated);
  }

  void removeImage(int index) {
    final updated = [...state.images]..removeAt(index);
    state = state.copyWith(images: updated);
  }

  void onReorder(int oldIndex, int newIndex) {
    final updatedImages = [...state.images];
    final oldItem = updatedImages.removeAt(oldIndex);
    int finalIndex = newIndex;
    if (oldIndex < newIndex) finalIndex--;
    updatedImages.insert(finalIndex, oldItem);
    state = state.copyWith(images: updatedImages);
    save();
  }

  Future<void> reset() async {
    await save();
    ref.invalidateSelf();
  }
}
