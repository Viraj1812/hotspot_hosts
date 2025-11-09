import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotspot_hosts/config/assets/colors.gen.dart';
import 'package:hotspot_hosts/constants/app_styles.dart';
import 'package:hotspot_hosts/features/onboarding/controller/onboarding_state_notifier.dart';
import 'package:hotspot_hosts/features/onboarding/view/widgets/action_buttons_widget.dart';
import 'package:hotspot_hosts/features/onboarding/view/widgets/recorded_file_widget.dart';
import 'package:hotspot_hosts/features/onboarding/view/widgets/recording_in_progress_widget.dart';
import 'package:hotspot_hosts/helpers/auto_route_navigation.dart';
import 'package:hotspot_hosts/helpers/toast_helper.dart';
import 'package:hotspot_hosts/routes/app_router.dart';
import 'package:hotspot_hosts/services/audio_service.dart';
import 'package:hotspot_hosts/services/video_service.dart';

class TextInputPageWidget extends ConsumerStatefulWidget {
  final Map<String, dynamic> question;
  final VoidCallback onNext;

  const TextInputPageWidget({super.key, required this.question, required this.onNext});

  @override
  ConsumerState<TextInputPageWidget> createState() => _TextInputPageWidgetState();
}

class _TextInputPageWidgetState extends ConsumerState<TextInputPageWidget> {
  final TextEditingController _textController = TextEditingController();
  final AudioService _audioService = AudioService();
  final VideoService _videoService = VideoService();

  @override
  void dispose() {
    _textController.dispose();
    _audioService.dispose();
    _videoService.dispose();
    super.dispose();
  }

  Future<void> _startAudioRecording() async {
    final success = await _audioService.startRecording();
    if (!success && mounted) {
      AppToastHelper.showError('Failed to start recording. Please check permissions.');
    }
  }

  Future<void> _stopAudioRecording() async {
    await _audioService.stopRecording();
  }

  Future<void> _startVideoRecording() async {
    final path = await _videoService.recordVideo();
    if (path == null && mounted) {
      AppToastHelper.showError('Video recording cancelled or failed');
    }
  }

  Future<void> _toggleAudioPlayback(String filePath) async {
    final success = await _audioService.togglePlayback(filePath);
    if (!success && mounted) {
      AppToastHelper.showError('Failed to play audio');
    }
  }

  Future<void> _playVideo(String filePath) async {
    try {
      if (mounted) {
        AutoRouteNavigation.push(VideoPlayerRoute(videoPath: filePath));
      }
    } catch (e) {
      debugPrint('Error opening video: $e');
      if (mounted) {
        AppToastHelper.showError('Failed to play video: $e');
      }
    }
  }

  void _deleteRecording() {
    if (_audioService.recordedFilePath.value != null) {
      _audioService.reset();
    }
    if (_videoService.recordedVideoPath.value != null) {
      _videoService.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _audioService.isRecording,
      builder: (context, isRecording, _) {
        return ValueListenableBuilder<String?>(
          valueListenable: _audioService.recordedFilePath,
          builder: (context, audioFilePath, _) {
            return ValueListenableBuilder<String?>(
              valueListenable: _videoService.recordedVideoPath,
              builder: (context, videoFilePath, _) {
                final recordedFilePath = audioFilePath ?? videoFilePath;
                final isVideo = videoFilePath != null;

                return LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      reverse: true,
                      padding: const EdgeInsets.all(16.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight - 32),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Text(
                                widget.question['id'].toString(),
                                style: AppStyles.getLightStyle(color: AppColors.white.withValues(alpha: 0.18)),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.question['question'],
                                style: AppStyles.getBoldStyle(color: AppColors.white, fontSize: 24),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.question['subtitle'],
                                style: AppStyles.getLightStyle(
                                  color: AppColors.white.withValues(alpha: 0.48),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  controller: _textController,
                                  onChanged: (value) {
                                    ref
                                        .read(onboardingStateNotifierProvider.notifier)
                                        .updateDescriptionScreenTwo(value);
                                  },
                                  maxLines: 10,
                                  maxLength: 600,
                                  textInputAction: TextInputAction.done,
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

                              // Show recording UI based on state
                              if (isRecording)
                                RecordingInProgressWidget(
                                  audioService: _audioService,
                                  onStopRecording: _stopAudioRecording,
                                )
                              else if (recordedFilePath != null)
                                RecordedFileWidget(
                                  filePath: recordedFilePath,
                                  isVideo: isVideo,
                                  audioService: _audioService,
                                  videoService: _videoService,
                                  onPlay: () {
                                    if (isVideo) {
                                      _playVideo(recordedFilePath);
                                    } else {
                                      _toggleAudioPlayback(recordedFilePath);
                                    }
                                  },
                                  onDelete: _deleteRecording,
                                  onNext: widget.onNext,
                                )
                              else
                                ActionButtonsWidget(
                                  audioService: _audioService,
                                  videoService: _videoService,
                                  onStartAudioRecording: _startAudioRecording,
                                  onStartVideoRecording: _startVideoRecording,
                                  onNext: widget.onNext,
                                  isTextNotEmpty: _textController.text.isNotEmpty,
                                  recordedFilePath: recordedFilePath,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
