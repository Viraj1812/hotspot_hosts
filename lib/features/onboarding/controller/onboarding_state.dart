import 'package:hotspot_hosts/features/onboarding/models/experience_response_data_model.dart';

class OnboardingState {
  OnboardingState({required this.isLoading, required this.experienceList});

  OnboardingState.initial();

  bool isLoading = false;
  List<Experiences> experienceList = [];

  OnboardingState copyWith({bool? isLoading, List<Experiences>? experienceList}) {
    return OnboardingState(
      isLoading: isLoading ?? this.isLoading,
      experienceList: experienceList ?? this.experienceList,
    );
  }
}
