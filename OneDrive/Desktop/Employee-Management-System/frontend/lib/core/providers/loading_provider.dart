import 'package:flutter_riverpod/flutter_riverpod.dart';

final globalLoadingProvider =
    StateNotifierProvider<GlobalLoadingNotifier, bool>(
  (ref) => GlobalLoadingNotifier(),
);

class GlobalLoadingNotifier
    extends StateNotifier<bool> {
  GlobalLoadingNotifier() : super(false);

  void show() => state = true;

  void hide() => state = false;
}
