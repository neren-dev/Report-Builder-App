import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

class AppReport {
  final String id;
  final String title;
  final List<ReportImage> images;
  final String comment;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  const AppReport({
    required this.id,
    this.title = '',
    this.images = const [],
    this.comment = '',
    required this.createdAt,
    required this.lastModifiedAt,
  });

  AppReport copyWith({
    String? id,
    String? title,
    List<ReportImage>? images,
    String? comment,
    DateTime? lastModifiedAt,
  }) {
    return AppReport(
      id: id ?? this.id,
      title: title ?? this.title,
      images: images ?? this.images,
      comment: comment ?? this.comment,
      createdAt: createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
    );
  }

  static AppReport initial() {
    return AppReport(
      id: const Uuid().v4(),
      createdAt: DateTime.now(),
      lastModifiedAt: DateTime.now(),
    );
  }

  static String createHash(AppReport report) {
    final data = jsonEncode({
      'id': report.id,
      'title': report.title,
      'comment': report.comment,
      'images': report.images
          .map((e) => {'id': e.id, 'path': e.path, 'caption': e.caption})
          .toList(),
      'createdAt': report.createdAt.toIso8601String(),
      'lastModifiedAt': report.lastModifiedAt.toIso8601String(),
    });

    return sha1.convert(utf8.encode(data)).toString();
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppReport && createHash(this) == createHash(other));
  }

  @override
  int get hashCode => createHash(this).hashCode;
}

class ReportImage {
  final String id;
  final String path;
  final String caption;

  const ReportImage({required this.id, required this.path, this.caption = ''});

  ReportImage copyWith({String? id, String? path, String? caption}) {
    return ReportImage(
      id: id ?? this.id,
      path: path ?? this.path,
      caption: caption ?? this.caption,
    );
  }
}
