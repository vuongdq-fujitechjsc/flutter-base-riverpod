import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/routes/app_router.dart';
import 'package:flutter_base_riverpod/routes/route_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    //handle config application

    //auto push to Login
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      ref.read(appRouterProvider).go(Routes.loginPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}