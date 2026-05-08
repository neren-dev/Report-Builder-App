import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;
import '../model/report.dart';
import 'package:flutter/foundation.dart';

Uint8List processImage(Uint8List bytes) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) return bytes;

  final resized = img.copyResize(decoded, width: 1000);
  return img.encodeJpg(resized, quality: 70);
}

final pdfServiceProvider = Provider<PdfService>((_) {
  return PdfService();
});

class PdfService {
  Uint8List? _cachedPdf;
  String? _lastHash;

  Future<Uint8List> getPdf(AppReport report) async {
    final newHash = AppReport.createHash(report);

    if (_cachedPdf != null && _lastHash == newHash) {
      return _cachedPdf!;
    }

    final bytes = await generateReport(report);

    _cachedPdf = bytes;
    _lastHash = newHash;

    return bytes;
  }

  Future<Uint8List> generateReport(AppReport report) async {
    final pdf = pw.Document();

    final List<pw.Widget> imageWidgets = [];

    // PREPROCESS IMAGES FIRST
    for (final imgData in report.images) {
      final file = File(imgData.path);

      final originalBytes = await file.readAsBytes();

      //  move heavy work off UI thread
      final compressedBytes = await compute(processImage, originalBytes);

      final pdfImage = pw.MemoryImage(compressedBytes);

      imageWidgets.add(
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Image(pdfImage, height: 180, fit: pw.BoxFit.contain),
            if (imgData.caption.isNotEmpty)
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 4),
                child: pw.Text(imgData.caption),
              ),
            pw.SizedBox(height: 12),
          ],
        ),
      );
    }

    final logoBytes = await rootBundle.load('assets/logo.jpg');
    final logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());

    // BUILD PDF
    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(24),
        build: (context) {
          return [
            /// LOGO
            pw.Center(
              child: pw.SizedBox.square(
                dimension: 80,
                child: pw.ClipOval(
                  child: pw.Image(
                    logoImage,
                    height: 80, // adjust as needed
                    fit: pw.BoxFit.contain,
                  ),
                ),
              ),
            ),

            pw.SizedBox(height: 12),

            /// HEADER
            if (report.title.isNotEmpty)
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    report.title,
                    style: pw.TextStyle(
                      fontSize: 22,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 6),
                  pw.Divider(thickness: 1),
                ],
              ),

            pw.SizedBox(height: 16),

            /// IMAGES SECTION
            ...imageWidgets.map(
              (widget) => pw.Inseparable(
                child: pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 16),
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(width: 0.5),
                    borderRadius: pw.BorderRadius.circular(6),
                  ),
                  child: widget,
                ),
              ),
            ),

            /// COMMENT SECTION
            if (report.comment.isNotEmpty) ...[
              pw.SizedBox(height: 12),
              pw.Text(
                "Additional Notes",
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 6),

              pw.Partition(
                child: pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(width: 0.5),
                    borderRadius: pw.BorderRadius.circular(6),
                  ),
                  child: pw.Text(
                    report.comment,
                    style: const pw.TextStyle(fontSize: 12),
                    overflow: pw.TextOverflow.span,
                  ),
                ),
              ),
            ],
          ];
        },
      ),
    );
    return pdf.save();
  }
}
