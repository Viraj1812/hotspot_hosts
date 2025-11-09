// Flutter imports:
import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotspot_hosts/config/assets/assets.gen.dart';
import 'package:hotspot_hosts/config/assets/colors.gen.dart';
import 'package:hotspot_hosts/features/splash/controller/splash_state_notifier.dart';
import 'package:hotspot_hosts/helpers/auto_route_navigation.dart';
import 'package:hotspot_hosts/routes/app_router.dart';

@RoutePage()
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(splashStateNotifierProvider.notifier).init(context);
      Future.delayed(const Duration(milliseconds: 1600), () async {
        AutoRouteNavigation.pushAndReplace(const OnboardingRoute());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1500),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: ClipOval(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset(AppAssets.images.logo.path, fit: BoxFit.cover),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
