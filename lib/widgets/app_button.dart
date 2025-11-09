import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hotspot_hosts/config/assets/assets.gen.dart';
import 'package:hotspot_hosts/config/assets/colors.gen.dart';
import 'package:hotspot_hosts/constants/app_styles.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;
  final bool isEnabled;

  const AppButton({super.key, required this.onPressed, required this.text, this.icon, this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    // Active state: bright white text, gradient border, vibrant gradient with buttonShade2 center
    // Inactive state: light grey text, gradient border, very subtle dark gradient
    final textColor = isEnabled ? AppColors.white : AppColors.buttonShade2;
    final iconColor = isEnabled ? AppColors.white : AppColors.buttonShade2;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              gradient: isEnabled
                  ? const LinearGradient(
                      colors: [AppColors.black, AppColors.white],
                      begin: Alignment.bottomRight,
                      end: Alignment.topCenter,
                    )
                  : LinearGradient(
                      colors: [AppColors.black.withValues(alpha: 0.5), AppColors.white.withValues(alpha: 0.5)],
                      begin: Alignment.bottomRight,
                      end: Alignment.topCenter,
                    ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: isEnabled
                      ? [
                          AppColors.buttonShade1, // Dark at edges
                          AppColors.buttonShade2, // Lighter in center
                          AppColors.buttonShade1, // Dark at edges
                        ]
                      : [
                          AppColors.buttonShade1,
                          AppColors.buttonShade1.withValues(alpha: 0.9), // Very subtle lighter center
                          AppColors.buttonShade1,
                        ],
                  stops: isEnabled ? const [0.0, 0.5, 1.0] : const [0.0, 0.4, 1.0],
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          text,
                          style: isEnabled
                              ? AppStyles.getMediumStyle(color: textColor, fontSize: 16)
                              : AppStyles.getLightStyle(color: textColor, fontSize: 16),
                        ),
                        const SizedBox(width: 8),
                        AppAssets.icons.nextIcon.svg(
                          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                          width: 14,
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
