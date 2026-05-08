import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:report_builder_app_mvp/features/report/ui/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MediaStore.ensureInitialized();

  MediaStore.appFolder = "ReportBuilder";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Report Builder (MVP)',
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Color.fromARGB(255, 0, 0, 255)),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
