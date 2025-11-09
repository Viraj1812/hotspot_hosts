import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hotspot_hosts/features/onboarding/controller/onboarding_state.dart';
import 'package:hotspot_hosts/features/onboarding/repository/onboarding_repository.dart';
import 'package:hotspot_hosts/helpers/toast_helper.dart';

final onboardingStateNotifierProvider = StateNotifierProvider<OnboardingStateNotifier, OnboardingState>(
  (ref) => OnboardingStateNotifier(onboardingRepository: ref.read(_onboardingRepository)),
);

final _onboardingRepository = Provider((ref) => OnboardingRepository());

class OnboardingStateNotifier extends StateNotifier<OnboardingState> {
  OnboardingStateNotifier({required this.onboardingRepository}) : super(OnboardingState.initial());

  final IOnboardingRepository onboardingRepository;

  Future<void> getExperienceList() async {
    state = state.copyWith(isLoading: true);
    final result = await onboardingRepository.getExperienceList();
    state = state.copyWith(isLoading: false);
    result.fold(AppErrorHandler.showError, (data) {
      state = state.copyWith(experienceList: data);
    });
  }
}
