import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotspot_hosts/config/assets/colors.gen.dart';
import 'package:hotspot_hosts/routes/app_route_handler.dart';
import 'package:toastification/toastification.dart';

void main() {
  AppRouteHandler.initRoute();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.black, // Color for Android
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.black,
        systemNavigationBarDividerColor: AppColors.black,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light, // light == black status bar for IOS.
      ),
      child: ToastificationWrapper(
        child: ProviderScope(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: child ?? SizedBox.shrink(),
                ),
              ),
              scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
              routerConfig: AppRouteHandler.route.config(),
            ),
          ),
        ),
      ),
    );
  }
}
