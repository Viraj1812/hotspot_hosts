import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:hotspot_hosts/features/onboarding/view/onboarding_screen.dart';
import 'package:hotspot_hosts/features/onboarding/view/thank_you_screen.dart';
import 'package:hotspot_hosts/features/onboarding/view/video_player_screen.dart';
import 'package:hotspot_hosts/features/splash/view/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: ThankYouRoute.page),
    AutoRoute(page: VideoPlayerRoute.page),
  ];
}
