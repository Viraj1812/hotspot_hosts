import 'package:flutter/material.dart';
import 'package:hotspot_hosts/config/assets/colors.gen.dart';
import 'package:hotspot_hosts/constants/app_strings.dart';
import 'package:hotspot_hosts/services/audio_service.dart';
import 'package:hotspot_hosts/services/video_service.dart';
import 'package:hotspot_hosts/widgets/app_button.dart';

class ActionButtonsWidget extends StatelessWidget {
  final AudioService audioService;
  final VideoService videoService;
  final VoidCallback onStartAudioRecording;
  final VoidCallback onStartVideoRecording;
  final VoidCallback onNext;
  final bool isTextNotEmpty;
  final String? recordedFilePath;

  const ActionButtonsWidget({
    super.key,
    required this.audioService,
    required this.videoService,
    required this.onStartAudioRecording,
    required this.onStartVideoRecording,
    required this.onNext,
    required this.isTextNotEmpty,
    this.recordedFilePath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MicrophoneButton(
          audioService: audioService,
          videoService: videoService,
          onTap: onStartAudioRecording,
        ),
        const SizedBox(width: 12),
        CameraButton(
          audioService: audioService,
          videoService: videoService,
          onTap: onStartVideoRecording,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AppButton(
            onPressed: onNext,
            text: AppStrings.next,
            isEnabled: isTextNotEmpty || recordedFilePath != null,
          ),
        ),
      ],
    );
  }
}

class MicrophoneButton extends StatelessWidget {
  final AudioService audioService;
  final VideoService videoService;
  final VoidCallback onTap;

  const MicrophoneButton({
    super.key,
    required this.audioService,
    required this.videoService,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: audioService.isRecording,
      builder: (context, isRecording, _) {
        return ValueListenableBuilder<String?>(
          valueListenable: videoService.recordedVideoPath,
          builder: (context, videoPath, _) {
            final isDisabled = isRecording || videoPath != null;
            return GestureDetector(
              onTap: isDisabled ? null : onTap,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[800]!),
                ),
                child: Icon(Icons.mic, color: isDisabled ? AppColors.white.withValues(alpha: 0.5) : AppColors.white),
              ),
            );
          },
        );
      },
    );
  }
}

class CameraButton extends StatelessWidget {
  final AudioService audioService;
  final VideoService videoService;
  final VoidCallback onTap;

  const CameraButton({
    super.key,
    required this.audioService,
    required this.videoService,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: audioService.isRecording,
      builder: (context, isRecording, _) {
        return ValueListenableBuilder<String?>(
          valueListenable: audioService.recordedFilePath,
          builder: (context, audioPath, _) {
            final isDisabled = isRecording || audioPath != null;
            return GestureDetector(
              onTap: isDisabled ? null : onTap,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[800]!),
                ),
                child: Icon(
                  Icons.videocam,
                  color: isDisabled ? AppColors.white.withValues(alpha: 0.5) : AppColors.white,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

