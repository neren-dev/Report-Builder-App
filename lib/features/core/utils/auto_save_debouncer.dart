import 'dart:async';

import 'package:flutter/rendering.dart';

class AutoSaveDebouncer {
  final Duration autoSaveDelay ;
  AutoSaveDebouncer({required this.autoSaveDelay});

  Timer? _timer;
  
  void runAutoSave(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(autoSaveDelay, action);
  }

  void disposeTimer() {
    _timer?.cancel();
  }
}
