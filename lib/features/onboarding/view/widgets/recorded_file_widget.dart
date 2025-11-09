import 'package:flutter/material.dart';
import 'package:hotspot_hosts/config/assets/colors.gen.dart';
import 'package:hotspot_hosts/constants/app_strings.dart';
import 'package:hotspot_hosts/constants/app_styles.dart';
import 'package:hotspot_hosts/features/onboarding/view/widgets/animated_waveform_widget.dart';
import 'package:hotspot_hosts/services/audio_service.dart';
import 'package:hotspot_hosts/services/video_service.dart';
import 'package:hotspot_hosts/widgets/app_button.dart';

class RecordedFileWidget extends StatelessWidget {
  final String filePath;
  final bool isVideo;
  final AudioService audioService;
  final VideoService videoService;
  final VoidCallback onPlay;
  final VoidCallback onDelete;
  final VoidCallback onNext;

  const RecordedFileWidget({
    super.key,
    required this.filePath,
    required this.isVideo,
    required this.audioService,
    required this.videoService,
    required this.onPlay,
    required this.onDelete,
    required this.onNext,
  });

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: audioService.isPlaying,
      builder: (context, isPlaying, _) {
        return ValueListenableBuilder<int>(
          valueListenable: isVideo ? videoService.videoDuration : audioService.recordingDuration,
          builder: (context, duration, _) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[800]!),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: onPlay,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4C6FFF),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Icon(
                            isVideo ? Icons.play_arrow : (isPlaying ? Icons.pause : Icons.play_arrow),
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isVideo ? 'Video Recorded' : 'Audio Recorded',
                              style: AppStyles.getLightStyle(color: AppColors.white, fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            if (!isVideo)
                              StaticWaveformWidget(
                                color: AppColors.white.withValues(alpha: 0.6),
                                barCount: 40,
                                barWidth: 2,
                                spacing: 1,
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _formatDuration(duration),
                        style: AppStyles.getLightStyle(color: AppColors.white.withValues(alpha: 0.6), fontSize: 12),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: onDelete,
                        child: Icon(Icons.delete_outline, color: AppColors.white.withValues(alpha: 0.6), size: 20),
                      ),
                    ],
                  ),
                ),
                AppButton(onPressed: onNext, text: AppStrings.next, isEnabled: true),
              ],
            );
          },
        );
      },
    );
  }
}

