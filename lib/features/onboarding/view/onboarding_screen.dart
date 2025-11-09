import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotspot_hosts/config/assets/colors.gen.dart';
import 'package:hotspot_hosts/features/onboarding/controller/onboarding_state_notifier.dart';
import 'package:hotspot_hosts/features/onboarding/view/widgets/selection_page_widget.dart';
import 'package:hotspot_hosts/features/onboarding/view/widgets/text_input_page_widget.dart';
import 'package:hotspot_hosts/helpers/auto_route_navigation.dart';
import 'package:hotspot_hosts/widgets/app_scaffold_with_background.dart';
import 'package:hotspot_hosts/widgets/wavy_progress_indicator.dart';

@RoutePage()
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _textController = TextEditingController();

  final ValueNotifier<List<dynamic>> _questionsNotifier = ValueNotifier([]);
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier(0);
  final ValueNotifier<bool> _isRecordingNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(onboardingStateNotifierProvider.notifier).getExperienceList();
    });
  }

  Future<void> _loadQuestions() async {
    const jsonString = '''
    {
      "questions": [
        {
          "id": "01",
          "question": "What kind of hotspots do you want to host?",
          "placeholder": "/ Start typing here",
          "type": "selection"
        },
        {
          "id": "02",
          "question": "Why do you want to host with us?",
          "placeholder": "Start typing here",
          "subtitle": "Tell us about your intent and what motivates you to create experiences.",
          "type": "text_input"
        }
      ]
    }
    ''';
    final data = json.decode(jsonString);
    _questionsNotifier.value = data['questions'];
  }

  @override
  void dispose() {
    _pageController.dispose();
    _textController.dispose();
    _questionsNotifier.dispose();
    _currentPageNotifier.dispose();
    _isRecordingNotifier.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPageNotifier.value < _questionsNotifier.value.length - 1) {
      _currentPageNotifier.value++;
      _pageController.animateToPage(
        _currentPageNotifier.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPageNotifier.value > 0) {
      _currentPageNotifier.value--;
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      AutoRouteNavigation.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<dynamic>>(
      valueListenable: _questionsNotifier,
      builder: (context, questions, _) {
        if (questions.isEmpty) {
          return const AppScaffoldWithBackground(
            body: Center(child: CircularProgressIndicator(color: AppColors.white)),
          );
        }

        return ValueListenableBuilder<int>(
          valueListenable: _currentPageNotifier,
          builder: (context, currentPage, _) {
            return AppScaffoldWithBackground(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                backgroundColor: AppColors.black,
                elevation: 0,
                title: WavyProgressIndicator(progress: (currentPage + 1) / questions.length),
                centerTitle: true,
                leading: IconButton(
                  onPressed: _previousPage,
                  icon: const Icon(Icons.arrow_back, color: AppColors.white),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      AutoRouteNavigation.back();
                    },
                    icon: const Icon(Icons.close, color: AppColors.white),
                  ),
                ],
              ),
              body: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: questions.length,
                onPageChanged: (index) {
                  _currentPageNotifier.value = index;
                },
                itemBuilder: (context, index) {
                  final question = questions[index];

                  if (question['type'] == 'selection') {
                    return SelectionPageWidget(question: question, onNext: _nextPage);
                  } else {
                    return TextInputPageWidget(question: question, onNext: _nextPage);
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
