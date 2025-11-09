import 'package:hotspot_hosts/features/onboarding/models/experience_response_data_model.dart';

class OnboardingState {
  OnboardingState({
    required this.isLoading,
    required this.experienceList,
    required this.selectedExperiences,
    required this.descriptionScreenOne,
    required this.descriptionScreenTwo,
  });

  OnboardingState.initial();

  bool isLoading = false;
  List<Experiences> experienceList = [];
  List<Experiences> selectedExperiences = [];
  String descriptionScreenOne = '';
  String descriptionScreenTwo = '';

  OnboardingState copyWith({
    bool? isLoading,
    List<Experiences>? experienceList,
    List<Experiences>? selectedExperiences,
    String? descriptionScreenOne,
    String? descriptionScreenTwo,
  }) {
    return OnboardingState(
      isLoading: isLoading ?? this.isLoading,
      experienceList: experienceList ?? this.experienceList,
      selectedExperiences: selectedExperiences ?? this.selectedExperiences,
      descriptionScreenOne: descriptionScreenOne ?? this.descriptionScreenOne,
      descriptionScreenTwo: descriptionScreenTwo ?? this.descriptionScreenTwo,
    );
  }
}
