import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await AdmobPlugin.initialize();

  QuickActionsPlugin.registerActions();

  Workmanager().initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
    isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );

  // Workmanager().registerOneOffTask(
  //   "com.fernandoherrera.miscelaneos.simpleTask1",
  //   "com.fernandoherrera.miscelaneos.simpleTask",
  //   inputData: { 'hola': 'mundo' },
  //   constraints: Constraints(
  //       networkType: NetworkType.connected,
  //       // requiresBatteryNotLow: true,
  //       // requiresCharging: true,
  //       // requiresDeviceIdle: true,
  //       // requiresStorageNotLow: true
  //   )
  // );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);


  runApp( const ProviderScope(child: MainApp()) );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addObserver(this);
    ref.read( permissionsProvider.notifier ).checkPermissions();

  }

  @override
  void dispose() {
    
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ref.read( appStateProvider.notifier ).state = state;
    if ( state == AppLifecycleState.resumed ) {
      ref.read( permissionsProvider.notifier ).checkPermissions();
    }
    super.didChangeAppLifecycleState(state);
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      
    );
  }
}



