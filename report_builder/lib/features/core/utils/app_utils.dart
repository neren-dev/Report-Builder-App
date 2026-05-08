import 'dart:io';
import 'package:flutter/material.dart';
import 'package:report_builder_app_mvp/features/core/ui/app_styles.dart';

class ImageCard extends StatefulWidget {
  final String path;
  final String caption;
  final Function(String) onCaptionChanged;
  final VoidCallback onDelete;
  final VoidCallback onChange;
  final int index;

  const ImageCard({
    super.key,
    required this.path,
    required this.caption,
    required this.onCaptionChanged,
    required this.onDelete,
    required this.onChange,
    required this.index,
  });

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.caption);
  }

  @override
  void didUpdateWidget(covariant ImageCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // sync when state changes
    if (oldWidget.caption != widget.caption) {
      controller.text = widget.caption;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ReorderableDragStartListener(
                index: widget.index,
                child: const Icon(Icons.drag_handle),
              ),
            ),

            const SizedBox(height: 8),

            Image.file(File(widget.path), height: 150),

            const SizedBox(height: 8),

            TextField(
              controller: controller,
              decoration: AppStyles.textField("Caption"),
              onChanged: widget.onCaptionChanged,
              maxLength: 1000,
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                TextButton(
                  onPressed: widget.onChange,
                  style: const ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Colors.blue),
                  ),
                  child: const Text("Change"),
                ),
                const Spacer(),
                TextButton(
                  onPressed: widget.onDelete,
                  style: const ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Colors.red),
                  ),
                  child: const Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TextAndAction {
  final String text;
  final VoidCallback action;

  const TextAndAction({required this.text, required this.action});
}
