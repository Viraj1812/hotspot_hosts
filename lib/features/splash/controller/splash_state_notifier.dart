// Flutter imports:
// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hotspot_hosts/constants/api_endpoints.dart';
import 'package:master_utility/master_utility.dart';
// Project imports:

final splashStateNotifierProvider = StateNotifierProvider<SplashStateNotifier, String>((ref) => SplashStateNotifier());

class SplashStateNotifier extends StateNotifier<String> {
  SplashStateNotifier() : super('');

  Future<void> init(BuildContext context) async {
    SizeHelper.setMediaQuerySize(context: context);
    try {
      dioClient.setConfiguration(APIEndpoints.baseUrl);
    } catch (e) {
      LogHelper.logError('SplashStateNotifier : $e');
    }
  }
}
