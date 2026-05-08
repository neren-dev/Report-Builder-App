import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_builder_app_mvp/features/report/service/date_formatters.dart';
import 'package:report_builder_app_mvp/features/report/state/sort_notifier.dart';
import 'package:report_builder_app_mvp/features/report/ui/report_menu.dart';
import 'package:report_builder_app_mvp/local/data/repo/db_repo.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(reportsProvider);
    final currentSort = ref.watch(reportsListSortByProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previous Reports"),
        actions: [
          MenuAnchor(
            menuChildren: SortBy.values.map<MenuItemButton>((e) {
              return MenuItemButton(
                style: ButtonStyle(
                  backgroundColor: currentSort == e
                      ? WidgetStatePropertyAll(Colors.blue.withAlpha(65))
                      : null,
                ),
                onPressed: () {
                  ref.read(reportsListSortByProvider.notifier).changeSort(e);
                },
                child: Text(switch (e) {
                  SortBy.lastModifiedDesc => "Last Modified Descending",
                  SortBy.lastModifiedAsc => "Last Modified Ascending",
                  SortBy.createdAtAsc => "Created At Ascending",
                  SortBy.createdAtDesc => "Created At Descending",
                }),
              );
            }).toList(),
            builder: (_, controller, _) {
              return IconButton(
                icon: const Icon(Icons.sort, color: Colors.blue),
                tooltip: 'Sort By',
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
              );
            },
          ),
        ],
      ),
      body: reportsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (reports) {
          if (reports.isEmpty) {
            return const Center(child: Text("No reports yet"));
          }

          return ListView.builder(
            key: const PageStorageKey('reports_list'),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];

              final firstImage = report.images.firstOrNull?.path;

              return ListTile(
                leading: firstImage != null && File(firstImage).existsSync()
                    ? Image.file(
                        File(firstImage),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.image_not_supported),

                title: Text(
                  report.title.isEmpty ? "Untitled Report" : report.title,
                ),

                subtitle: Text(formatDate(report.createdAt.toLocal())),

                onTap: () {
                  showOptions(
                    context,
                    ref,
                    report,
                    showEdit: true,
                    showDelete: true,
                    showDuplicate: true,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
