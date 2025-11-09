import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoService {
  final ImagePicker _imagePicker = ImagePicker();

  final ValueNotifier<String?> recordedVideoPath = ValueNotifier(null);
  final ValueNotifier<int> videoDuration = ValueNotifier(0);

  Future<String?> recordVideo() async {
    try {
      debugPrint('Starting video recording...');
      final XFile? video = await _imagePicker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(minutes: 2),
      );

      if (video != null) {
        debugPrint('Video recorded at: ${video.path}');
        recordedVideoPath.value = video.path;

        // Get video duration
        try {
          final videoController = VideoPlayerController.file(File(video.path));
          await videoController.initialize();
          videoDuration.value = videoController.value.duration.inSeconds;
          await videoController.dispose();
          debugPrint('Video duration: ${videoDuration.value}s');
        } catch (e) {
          debugPrint('Error getting video duration: $e');
          videoDuration.value = 0;
        }

        return video.path;
      } else {
        debugPrint('Video recording cancelled');
        return null;
      }
    } catch (e) {
      debugPrint('Error recording video: $e');
      return null;
    }
  }

  void reset() {
    recordedVideoPath.value = null;
    videoDuration.value = 0;
  }

  void dispose() {
    recordedVideoPath.dispose();
    videoDuration.dispose();
  }
}
