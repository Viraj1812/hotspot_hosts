// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotspot_hosts/config/assets/assets.gen.dart';
import 'package:hotspot_hosts/config/assets/colors.gen.dart';

class AppScaffoldWithBackground extends ConsumerWidget {
  const AppScaffoldWithBackground({
    this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.bottomButton,
    this.resizeToAvoidBottomInset,
    super.key,
  });

  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? bottomButton;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
      extendBody: true,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(top: 0, bottom: 0, left: 0, right: 0, child: AppAssets.images.bg.image(fit: BoxFit.cover)),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Expanded(child: body ?? const SizedBox.shrink()),
                      if (bottomButton != null) ...[
                        const SizedBox(height: 5),
                        SafeArea(child: bottomButton ?? const SizedBox.shrink()),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
