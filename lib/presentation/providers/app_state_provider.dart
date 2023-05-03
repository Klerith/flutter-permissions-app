import 'package:flutter/material.dart' show AppLifecycleState;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
    resumed
    inactive
    paused
    detached
*/ 
final appStateProvider = StateProvider<AppLifecycleState>((ref) {
  return AppLifecycleState.resumed;
});