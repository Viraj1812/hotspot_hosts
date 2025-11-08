import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotspot_hosts/routes/app_route_handler.dart';

BuildContext get globalContext => AutoRouteNavigation.currentContext!;

/// Auto Route Navigation Helper
/// Provides app-level navigation functionality using auto_route v10
class AutoRouteNavigation {
  static StackRouter get _router => AppRouteHandler.route;

  /// Get current navigation context
  static BuildContext? get currentContext => _router.navigatorKey.currentContext;

  /// Navigate back with optional result
  static void back([Object? result]) {
    if (_router.canPop()) {
      _router.pop(result);
    }
  }

  /// Push a new route
  static Future<T?> push<T extends Object?>(PageRouteInfo route) async {
    return _router.push<T>(route);
  }

  /// Push and replace current route
  static Future<T?> pushAndReplace<T extends Object?>(PageRouteInfo route) async {
    return _router.replace<T>(route);
  }

  /// Push and remove all previous routes
  static Future<void> pushAndClearStack(PageRouteInfo route) async {
    _router.popUntilRoot();
    await _router.push(route);
  }

  /// Navigate to route and remove routes until predicate is satisfied
  static Future<void> pushAndRemoveUntil(PageRouteInfo route, {bool Function(Route<dynamic>)? predicate}) async {
    await _router.push(route);
    if (predicate == null) {
      _router.popUntil((_) => false);
    } else {
      _router.popUntil(predicate);
    }
  }

  /// Pop until specific route name
  static void popUntil(String routeName) {
    _router.popUntilRouteWithName(routeName);
  }

  /// Pop until specific count of routes
  // static void popUntilCount(int count) {
  //   var currentCount = 0;
  //   _router.popUntil((route) {
  //     currentCount++;
  //     return currentCount == count;
  //   });
  // }
}
