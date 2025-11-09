import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotspot_hosts/config/assets/colors.gen.dart';
import 'package:hotspot_hosts/constants/app_styles.dart';
import 'package:hotspot_hosts/features/onboarding/controller/onboarding_state_notifier.dart';
import 'package:hotspot_hosts/widgets/app_scaffold_with_background.dart';
import 'package:master_utility/master_utility.dart';

@RoutePage()
class ThankYouScreen extends ConsumerWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingStateNotifierProvider);

    return AppScaffoldWithBackground(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Thank You Title
              Text('Thank You!', style: AppStyles.getBoldStyle(color: AppColors.white, fontSize: 32)),
              const SizedBox(height: 8),
              Text(
                'We appreciate you taking the time to share your thoughts with us.',
                style: AppStyles.getLightStyle(color: AppColors.white.withValues(alpha: 0.7), fontSize: 16),
              ),
              const SizedBox(height: 40),

              // Selected Hotspots Section
              if (state.selectedExperiences.isNotEmpty) ...[
                Text('Your Selected Hotspots', style: AppStyles.getBoldStyle(color: AppColors.white, fontSize: 20)),
                const SizedBox(height: 16),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.selectedExperiences.length,
                    itemBuilder: (context, index) {
                      final experience = state.selectedExperiences[index];
                      return Container(
                        width: 200,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.purple.withValues(alpha: 0.3), width: 1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              // Background Image
                              if (experience.imageUrl != null)
                                Positioned.fill(
                                  child: AppNetworkImage(
                                    url: experience.imageUrl!,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, error, stack) => Container(
                                      color: AppColors.buttonShade1,
                                      child: Center(
                                        child: Icon(
                                          Icons.image_outlined,
                                          color: AppColors.white.withValues(alpha: 0.3),
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              // Gradient Overlay
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Colors.transparent, AppColors.black.withValues(alpha: 0.7)],
                                    ),
                                  ),
                                ),
                              ),
                              // Content
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (experience.name != null)
                                        Text(
                                          experience.name!,
                                          style: AppStyles.getBoldStyle(color: AppColors.white, fontSize: 16),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      if (experience.tagline != null) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          experience.tagline!,
                                          style: AppStyles.getLightStyle(
                                            color: AppColors.white.withValues(alpha: 0.8),
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ],

              // Description Section
              if (state.descriptionScreenOne.isNotEmpty) ...[
                Text(
                  'Your Response for Question 1',
                  style: AppStyles.getBoldStyle(color: AppColors.white, fontSize: 20),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.purple.withValues(alpha: 0.3), width: 1),
                  ),
                  child: Text(
                    state.descriptionScreenOne,
                    style: AppStyles.getRegularStyle(color: AppColors.white.withValues(alpha: 0.9), fontSize: 16),
                  ),
                ),
                const SizedBox(height: 32),
              ],
              if (state.descriptionScreenTwo.isNotEmpty) ...[
                Text(
                  'Your Response for Question 2',
                  style: AppStyles.getBoldStyle(color: AppColors.white, fontSize: 20),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.purple.withValues(alpha: 0.3), width: 1),
                  ),
                  child: Text(
                    state.descriptionScreenTwo,
                    style: AppStyles.getRegularStyle(color: AppColors.white.withValues(alpha: 0.9), fontSize: 16),
                  ),
                ),
                const SizedBox(height: 32),
              ],

              // Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.purple.withValues(alpha: 0.2), AppColors.purple.withValues(alpha: 0.1)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.purple.withValues(alpha: 0.4), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.purple.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.check_circle_outline, color: AppColors.purple, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Your information has been received',
                            style: AppStyles.getBoldStyle(color: AppColors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'We\'ll review your submission and get back to you soon. Thank you for being part of our community!',
                      style: AppStyles.getLightStyle(color: AppColors.white.withValues(alpha: 0.8), fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
