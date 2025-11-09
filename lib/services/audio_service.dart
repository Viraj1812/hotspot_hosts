import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as ja;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class AudioService {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final ja.AudioPlayer _audioPlayer = ja.AudioPlayer();

  Timer? _recordingTimer;
  StreamSubscription? _playerStateSubscription;

  final ValueNotifier<bool> isRecording = ValueNotifier(false);
  final ValueNotifier<bool> isPlaying = ValueNotifier(false);
  final ValueNotifier<int> recordingDuration = ValueNotifier(0);
  final ValueNotifier<String?> recordedFilePath = ValueNotifier(null);

  Future<bool> requestPermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<bool> startRecording() async {
    try {
      final hasPermission = await requestPermission();
      if (!hasPermission) {
        debugPrint('Microphone permission denied');
        return false;
      }

      if (!await _audioRecorder.hasPermission()) {
        debugPrint('AudioRecorder does not have permission');
        return false;
      }

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

      debugPrint('Starting audio recording at: $filePath');

      await _audioRecorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 128000, sampleRate: 44100),
        path: filePath,
      );

      isRecording.value = true;
      recordingDuration.value = 0;

      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        recordingDuration.value++;
      });

      return true;
    } catch (e) {
      debugPrint('Error starting audio recording: $e');
      return false;
    }
  }

  Future<String?> stopRecording() async {
    try {
      debugPrint('Stopping audio recording...');
      final path = await _audioRecorder.stop();
      _recordingTimer?.cancel();
      isRecording.value = false;

      if (path != null) {
        recordedFilePath.value = path;
        debugPrint('Audio file saved at: $path');
        return path;
      }

      return null;
    } catch (e) {
      debugPrint('Error stopping audio recording: $e');
      return null;
    }
  }

  Future<bool> togglePlayback(String filePath) async {
    try {
      if (isPlaying.value) {
        await _audioPlayer.pause();
        isPlaying.value = false;
      } else {
        await _audioPlayer.setFilePath(filePath);

        _playerStateSubscription?.cancel();
        _playerStateSubscription = _audioPlayer.playerStateStream.listen((state) {
          isPlaying.value = state.playing;
        });

        await _audioPlayer.play();
      }
      return true;
    } catch (e) {
      debugPrint('Error playing audio: $e');
      return false;
    }
  }

  Future<void> stopPlayback() async {
    await _audioPlayer.stop();
    isPlaying.value = false;
  }

  void reset() {
    recordedFilePath.value = null;
    recordingDuration.value = 0;
    isPlaying.value = false;
    isRecording.value = false;
    stopPlayback();
    _playerStateSubscription?.cancel();
  }

  void dispose() {
    _recordingTimer?.cancel();
    _playerStateSubscription?.cancel();
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    isRecording.dispose();
    isPlaying.dispose();
    recordingDuration.dispose();
    recordedFilePath.dispose();
  }
}
