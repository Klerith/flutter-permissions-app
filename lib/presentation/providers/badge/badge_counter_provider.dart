import 'package:flutter_riverpod/flutter_riverpod.dart';



final badgeCounterProvider = StateProvider<int>((ref) {
  return 0;
});