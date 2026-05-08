import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_builder_app_mvp/features/report/model/report.dart';
import 'package:report_builder_app_mvp/features/report/ui/home.dart';
import 'package:report_builder_app_mvp/features/report/ui/reports_screen.dart';

class MainScreen extends StatefulWidget {
  final AppReport? report;
  const MainScreen({super.key, this.report});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  late final PageController _controller;

  List<ConsumerStatefulWidget> get screens => [
    HomeScreen(report: widget.report),
    const ReportsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (i) {
          setState(() => index = i);
        },
        children: screens,
      ),

      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.blue,
        selectedIndex: index,
        onDestinationSelected: (i) {
          _controller.animateToPage(
            i,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.edit), label: 'Create'),
          NavigationDestination(icon: Icon(Icons.history), label: 'Reports'),
        ],
      ),
    );
  }
}
