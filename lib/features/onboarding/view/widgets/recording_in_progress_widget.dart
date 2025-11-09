import 'package:flutter/material.dart';
import 'package:hotspot_hosts/config/assets/colors.gen.dart';
import 'package:hotspot_hosts/constants/app_styles.dart';
import 'package:hotspot_hosts/features/onboarding/view/widgets/animated_waveform_widget.dart';
import 'package:hotspot_hosts/services/audio_service.dart';

class RecordingInProgressWidget extends StatelessWidget {
  final AudioService audioService;
  final VoidCallback onStopRecording;

  const RecordingInProgressWidget({
    super.key,
    required this.audioService,
    required this.onStopRecording,
  });

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: audioService.recordingDuration,
      builder: (context, duration, _) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[800]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Recording Audio...', style: AppStyles.getLightStyle(color: AppColors.white, fontSize: 14)),
              const SizedBox(height: 16),
              Row(
                children: [
                  GestureDetector(
                    onTap: onStopRecording,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4C6FFF),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Icon(Icons.stop, color: Colors.white, size: 24),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AnimatedWaveformWidget(
                      color: AppColors.white,
                      barCount: 30,
                      barWidth: 3,
                      spacing: 1.5,
                      isAnimating: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(_formatDuration(duration), style: AppStyles.getLightStyle(color: AppColors.white, fontSize: 14)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

