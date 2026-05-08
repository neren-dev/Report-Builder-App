import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report_builder_app_mvp/features/core/ui/app_styles.dart';
import 'package:report_builder_app_mvp/features/core/utils/app_utils.dart';
import 'package:report_builder_app_mvp/features/core/utils/auto_save_debouncer.dart';
import 'package:report_builder_app_mvp/features/report/model/report.dart';
import 'package:report_builder_app_mvp/features/report/ui/report_menu.dart';

import '../state/notifier.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final AppReport? report;
  const HomeScreen({super.key, this.report});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late final TextEditingController titleController;
  late final TextEditingController commentController;
  late AppReport _report;
  late final AutoSaveDebouncer _autoSaveDebouncer;

  void _syncController(TextEditingController c, String value) {
    if (c.text != value) {
      c.value = c.value.copyWith(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _report = widget.report ?? AppReport.initial();
    titleController = TextEditingController();
    commentController = TextEditingController();
    _autoSaveDebouncer = AutoSaveDebouncer(
      autoSaveDelay: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    commentController.dispose();
    _autoSaveDebouncer.disposeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final report = ref.watch(reportProvider(_report));
    final notifier = ref.read(reportProvider(_report).notifier);

    ref.listen(reportProvider(_report), (_, _) {
      _autoSaveDebouncer.runAutoSave(notifier.save);
    });

    final picker = ImagePicker();

    _syncController(titleController, report.title);
    _syncController(commentController, report.comment);

    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blue,
          selectionColor: Colors.blue,
          selectionHandleColor: Colors.blue,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Report Builder'),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _report = AppReport.initial();
                });
                notifier.reset();
              },
              tooltip: 'Reset',
              icon: const Icon(Icons.cancel, semanticLabel: 'Reset'),
            ),
            IconButton(
              onPressed: () async {
                if (report.images.isEmpty) {
                  showInfo(context, "Add at least 1 image");
                  return;
                }
                await notifier.save();
                if (!context.mounted) return;
                showInfo(context, 'Report Saved');
              },
              tooltip: 'Save',
              icon: const Icon(Icons.check_circle, semanticLabel: 'Save'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomScrollView(
            slivers: [
              /// TITLE
              SliverToBoxAdapter(
                child: TextField(
                  controller: titleController,
                  decoration: AppStyles.textField("Title"),
                  onChanged: notifier.setTitle,
                  maxLength: 200,
                ),
              ),
              const SliverToBoxAdapter(child: Divider(height: 40)),
              SliverToBoxAdapter(
                child:
                    /// HEADER
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Images",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child:
                    /// ADD IMAGE
                    Center(
                      child: OutlinedButton(
                        style: const ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(Colors.blue),
                        ),
                        onPressed: () async {
                          if (report.images.length >= 4) {
                            showInfo(context, "Maximum 4 images allowed");
                            return;
                          }

                          final picked = await picker.pickImage(
                            source: ImageSource.gallery,
                          );

                          if (picked != null) {
                            notifier.addImage(picked.path);
                          }
                        },
                        child: const Text("Add Image"),
                      ),
                    ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),

              SliverReorderableList(
                itemBuilder: (context, index) {
                  final img = report.images[index];
                  final i = index;
                  return ImageCard(
                    key: ValueKey(img.id),
                    index: i,
                    path: img.path,
                    caption: img.caption,
                    onCaptionChanged: (v) => notifier.updateCaption(i, v),
                    onDelete: () => notifier.removeImage(i),
                    onChange: () async {
                      final picked = await picker.pickImage(
                        source: ImageSource.gallery,
                      );

                      if (picked != null) {
                        notifier.updateImage(i, picked.path);
                      }
                    },
                  );
                },
                itemCount: report.images.length,
                onReorder: notifier.onReorder,
              ),

              const SliverToBoxAdapter(child: Divider(height: 40)),
              SliverToBoxAdapter(
                child:
                    /// COMMENT
                    TextField(
                      controller: commentController,
                      decoration: AppStyles.textField("Additional Notes"),
                      maxLines: 4,
                      maxLength: 1000,
                      onChanged: notifier.setComment,
                    ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child:
                    /// GENERATE
                    Center(
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(Colors.blue),
                        ),
                        onPressed: () async {
                          if (report.images.isEmpty) {
                            showInfo(context, "Add at least 1 image");
                            return;
                          }

                          /// Loader
                          showLoaderDialog(context);

                          await notifier.save();

                          // final bytes = await ref
                          //     .read(pdfServiceProvider)
                          //     .getPdf(report);

                          if (!context.mounted) return;

                          Navigator.pop(context); // close loader

                          /// Bottom Sheet
                          showOptions(context, ref, report, showDelete: false);
                        },
                        child: const Text("Generate PDF"),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
