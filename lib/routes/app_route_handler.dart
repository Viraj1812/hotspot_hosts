import 'package:get_it/get_it.dart';
import 'package:hotspot_hosts/routes/app_router.dart';

class AppRouteHandler {
  AppRouteHandler._();

  static void initRoute() {
    GetIt.instance.registerSingleton<AppRouter>(AppRouter());
  }

  static AppRouter get route => GetIt.instance.get<AppRouter>();
}
