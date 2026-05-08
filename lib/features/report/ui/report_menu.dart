import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:printing/printing.dart';
import 'package:report_builder_app_mvp/features/report/model/report.dart';
import 'package:report_builder_app_mvp/features/report/service/pdf.dart';
import 'package:report_builder_app_mvp/features/report/state/notifier.dart';
import 'package:report_builder_app_mvp/features/report/ui/main_screen.dart';
import 'package:report_builder_app_mvp/local/data/repo/db_repo.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

void showInfo(
  BuildContext context,
  String msg, {
  SnackBarAction? action,
  bool? persist,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      action: action == null
          ? null
          : SnackBarAction(
              label: action.label,
              onPressed: action.onPressed,
              textColor: Colors.blue,
            ),
      persist: persist,
    ),
  );
}

Future<void> showLoaderDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const PopScope(
      canPop: false,
      child: Center(child: CircularProgressIndicator(color: Colors.blue)),
    ),
  );
}

Future<void> downloadPdf(
  BuildContext context,
  WidgetRef ref,
  AppReport report,
) async {
  showLoaderDialog(context);

  try {
    final bytes = await ref.read(pdfServiceProvider).getPdf(report);

    final fileName = "${report.title.isEmpty ? "report" : report.title}.pdf";

    if (Platform.isAndroid) {
      final sdk = await MediaStore().getPlatformSDKInt();

      if (sdk >= 30) {
        // Android 11+ → MediaStore (silent)
        final saveInfo = await saveToDownloads(bytes, fileName);

        if (!context.mounted) return;

        if (Navigator.canPop(context)) Navigator.pop(context);

        if (saveInfo == null) {
          showInfo(context, "Failed to save file");
        } else {
          showInfo(context, "Saved to Downloads");
        }
        return;
      }
    }

    // ⚠️ Android 10 fallback → SAF (user picks location)
    final path = await FilePicker.saveFile(
      dialogTitle: 'Save PDF',
      fileName: fileName,
      bytes: bytes,
    );

    if (!context.mounted) return;

    if (Navigator.canPop(context)) Navigator.pop(context);

    if (path == null) {
      showInfo(context, "Cancelled");
      return;
    }

    if (!context.mounted) return;
    showInfo(context, "Saved successfully");
  } catch (e, stack) {
    debugPrint("ERROR: $e");
    debugPrintStack(stackTrace: stack);
    if (Navigator.canPop(context)) Navigator.pop(context);
    showInfo(context, "Error: $e", persist: true);
  }
}

Future<SaveInfo?> saveToDownloads(Uint8List bytes, String fileName) async {
  final mediaStore = MediaStore();

  return mediaStore.saveFile(
    tempFilePath: await _createTempFile(bytes, fileName),
    dirType: DirType.download,
    dirName: DirName.download,
  );
}

Future<String> _createTempFile(Uint8List bytes, String name) async {
  final tempDir = Directory.systemTemp;
  final file = File('${tempDir.path}/$name.pdf');
  await file.writeAsBytes(bytes);
  return file.path;
}

void showOptions(
  BuildContext context,
  WidgetRef ref,
  AppReport report, {
  bool showEdit = false,
  bool showDelete = false,
  bool showDuplicate = false,
}) {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// CANCEL
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text("Cancel"),
                onTap: () => Navigator.pop(context),
              ),

              /// VIEW
              ListTile(
                leading: const Icon(Icons.visibility),
                title: const Text("View PDF"),
                onTap: () async {
                  Navigator.pop(context);

                  showLoaderDialog(context);

                  final bytes = await ref
                      .read(pdfServiceProvider)
                      .getPdf(report);

                  await Printing.layoutPdf(onLayout: (_) async => bytes);

                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
              ),

              /// DOWNLOAD
              ListTile(
                leading: const Icon(Icons.download),
                title: const Text("Download PDF"),
                onTap: () async {
                  Navigator.pop(context);
                  await downloadPdf(context, ref, report);
                },
              ),

              /// EDIT
              if (showEdit)
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text("Edit"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MainScreen(report: report);
                        },
                      ),
                    );
                  },
                ),

              /// DUPLICATE
              if (showDuplicate)
                ListTile(
                  leading: const Icon(Icons.control_point_duplicate),
                  title: const Text("Duplicate"),
                  onTap: () async {
                    Navigator.pop(context);

                    showLoaderDialog(context);

                    final newReport = report.copyWith(
                      id: const Uuid().v4(),
                      images: report.images
                          .map((e) => e.copyWith(id: const Uuid().v4()))
                          .toList(),
                    );
                    await ref.read(reportProvider(newReport).notifier).save();
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  },
                ),

              /// SHARE
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text("Share PDF"),
                onTap: () async {
                  Navigator.pop(context);

                  showLoaderDialog(context);

                  final bytes = await ref
                      .read(pdfServiceProvider)
                      .getPdf(report);
                  final result = await SharePlus.instance.share(
                    ShareParams(
                      files: [
                        XFile.fromData(
                          bytes,
                          name:
                              'report_${DateTime.now().millisecondsSinceEpoch}.pdf',
                          mimeType: 'application/pdf',
                        ),
                      ],
                    ),
                  );

                  if (!context.mounted) return;
                  Navigator.pop(context);
                  if (result.status == ShareResultStatus.success) {
                    showInfo(context, "Shared successfully");
                  }
                },
              ),

              /// DELETE
              if (showDelete)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () async {
                    Navigator.pop(context);

                    await ref.read(reportRepoProvider).deleteReport(report.id);

                    ref.invalidate(reportsProvider);
                    if (!context.mounted) return;
                    showInfo(
                      context,
                      'Deleted',
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          ref.read(reportRepoProvider).saveReport(report);
                        },
                      ),
                      persist: true,
                    );
                  },
                ),
            ],
          ),
        ),
      );
    },
  );
}
