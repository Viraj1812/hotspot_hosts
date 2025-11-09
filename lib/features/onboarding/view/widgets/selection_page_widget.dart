import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotspot_hosts/config/assets/colors.gen.dart';
import 'package:hotspot_hosts/constants/app_strings.dart';
import 'package:hotspot_hosts/constants/app_styles.dart';
import 'package:hotspot_hosts/features/onboarding/controller/onboarding_state_notifier.dart';
import 'package:master_utility/master_utility.dart';

class SelectionPageWidget extends ConsumerStatefulWidget {
  final Map<String, dynamic> question;
  final VoidCallback onNext;

  const SelectionPageWidget({super.key, required this.question, required this.onNext});

  @override
  ConsumerState<SelectionPageWidget> createState() => _SelectionPageWidgetState();
}

class _SelectionPageWidgetState extends ConsumerState<SelectionPageWidget> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  double _getRotationAngle(int index) {
    final remainder = index % 3;
    if (remainder == 0) {
      return -0.05236; // -3 degrees (left tilt)
    } else if (remainder == 1) {
      return 0.05236; // +3 degrees (right tilt)
    }
    return 0.0; // No tilt
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingStateNotifierProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          reverse: true, // Makes content stick to bottom when keyboard is closed
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - 32, // Account for padding
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(), // Pushes content to bottom when no keyboard
                  Text(
                    widget.question['id'].toString(),
                    style: AppStyles.getLightStyle(color: AppColors.white.withValues(alpha: 0.18)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.question['question'],
                    style: AppStyles.getBoldStyle(color: AppColors.white, fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 101,
                    child: state.isLoading
                        ? const Center(child: CircularProgressIndicator(color: AppColors.white))
                        : state.experienceList.isEmpty
                        ? Center(
                            child: Text(
                              AppStrings.noExperienceFound,
                              style: AppStyles.getRegularStyle(color: AppColors.white),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.experienceList.length,
                            itemBuilder: (context, index) {
                              final experience = state.experienceList[index];
                              final isSelected = state.selectedExperiences.any((e) => e.id == experience.id);

                              return GestureDetector(
                                onTap: () {
                                  ref
                                      .read(onboardingStateNotifierProvider.notifier)
                                      .toggleExperienceSelection(experience);
                                },
                                child: Transform.rotate(
                                  angle: _getRotationAngle(index),
                                  child: Container(
                                    width: 96,
                                    height: 96,
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Stack(
                                      children: [
                                        // Background Image
                                        if (experience.imageUrl != null)
                                          Positioned.fill(
                                            child: isSelected
                                                ? AppNetworkImage(
                                                    url: experience.imageUrl!,
                                                    errorWidget: (context, error, stack) =>
                                                        Container(color: Colors.grey[800]),
                                                  )
                                                : ColorFiltered(
                                                    colorFilter: const ColorFilter.matrix([
                                                      0.2126,
                                                      0.7152,
                                                      0.0722,
                                                      0,
                                                      0,
                                                      0.2126,
                                                      0.7152,
                                                      0.0722,
                                                      0,
                                                      0,
                                                      0.2126,
                                                      0.7152,
                                                      0.0722,
                                                      0,
                                                      0,
                                                      0,
                                                      0,
                                                      0,
                                                      1,
                                                      0,
                                                    ]),
                                                    child: AppNetworkImage(
                                                      url: experience.imageUrl!,
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context, error, stack) =>
                                                          Container(color: Colors.grey[800]),
                                                    ),
                                                  ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: _textController,
                      onChanged: (value) {
                        ref.read(onboardingStateNotifierProvider.notifier).updateDescription(value);
                      },
                      maxLines: 6,
                      maxLength: 250,
                      style: const TextStyle(color: AppColors.white),
                      decoration: InputDecoration(
                        hintText: widget.question['placeholder'],
                        hintStyle: AppStyles.getLightStyle(
                          color: AppColors.white.withValues(alpha: 0.16),
                          fontSize: 20,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                        counterText: '',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: widget.onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.grey[800]!),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Next',
                            style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, color: AppColors.white, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
