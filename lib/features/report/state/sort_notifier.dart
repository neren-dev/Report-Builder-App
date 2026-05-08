import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final reportsListSortByProvider = NotifierProvider(ReportsListSortNotifier.new);

class ReportsListSortNotifier extends Notifier<SortBy> {
  @override
  build() {
    return SortBy.lastModifiedDesc;
  }

  Future<void> changeSort(SortBy sortBy) async {
    state = sortBy;
    await ref.read(uiSortAsyncProvider.notifier).switchSortMode(sortBy);
  }
}

final uiSortAsyncProvider = AsyncNotifierProvider(UiSortNotifier.new);

class UiSortNotifier extends AsyncNotifier<SortBy> {
  late SharedPreferencesAsync _sharedPrefs;
  static const _currentSortModeKey = "currentSortModeKey";

  @override
  Future<SortBy> build() async {
    _sharedPrefs = SharedPreferencesAsync();
    return await getCurrentSortMode();
  }

  SortBy sortModeFromString(String mode) {
    // values.where would give list, but values.firstWhere gives the item, thats why it is used
    // this can but crash without orElse parameter when :
    /* If:
        shared prefs gets corrupted
        rename enum values
        user downgrades app
        💥 App crashes on startup
     */
    return SortBy.values.firstWhere(
      (m) => m.name == mode,
      orElse: () => SortBy.lastModifiedDesc,
    );
  }

  Future<SortBy> getCurrentSortMode() async {
    final mode =
        await _sharedPrefs.getString(_currentSortModeKey) ??
        SortBy.lastModifiedDesc.name;
    return sortModeFromString(mode);
  }

  Future<void> switchSortMode(SortBy mode) async {
    await _sharedPrefs.setString(_currentSortModeKey, mode.name);

    state = AsyncData(mode);
  }
}

enum SortBy { lastModifiedDesc, lastModifiedAsc, createdAtAsc, createdAtDesc }
