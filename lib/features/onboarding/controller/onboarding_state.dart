class OnboardingState {
  OnboardingState({
    required this.isLoading,
  });

  OnboardingState.initial();

  bool isLoading = false;

  OnboardingState copyWith({
    bool? isLoading,
  }) {
    return OnboardingState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
