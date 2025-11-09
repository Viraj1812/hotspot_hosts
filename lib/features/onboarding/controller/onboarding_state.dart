import 'package:hotspot_hosts/features/onboarding/models/experience_response_data_model.dart';

class OnboardingState {
  OnboardingState({
    required this.isLoading,
    required this.experienceList,
    required this.selectedExperiences,
    required this.description,
  });

  OnboardingState.initial();

  bool isLoading = false;
  List<Experiences> experienceList = [];
  List<Experiences> selectedExperiences = [];
  String description = '';

  OnboardingState copyWith({
    bool? isLoading,
    List<Experiences>? experienceList,
    List<Experiences>? selectedExperiences,
    String? description,
  }) {
    return OnboardingState(
      isLoading: isLoading ?? this.isLoading,
      experienceList: experienceList ?? this.experienceList,
      selectedExperiences: selectedExperiences ?? this.selectedExperiences,
      description: description ?? this.description,
    );
  }
}
