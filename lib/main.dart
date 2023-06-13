import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/shared/routes/app_router.dart';
import 'package:flutter_base_riverpod/shared/storage/local_storage_helper.dart';
import 'package:flutter_base_riverpod/shared/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageManagement.init();
  await LocalStorageProvider.init();

  runApp(ProviderScope(observers: [Logger()], child: const MyApp()));
}

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    print('''{
      "provider": "${provider.name ?? provider.runtimeType}",
      "newValue": "$newValue"
    }''');
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(routerConfig: router);
  }
}
