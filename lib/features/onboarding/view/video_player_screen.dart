import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;

  const VideoPlayerScreen({super.key, required this.videoPath});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  final ValueNotifier<bool> _isInitialized = ValueNotifier(false);
  final ValueNotifier<String?> _errorMessage = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.file(File(widget.videoPath));
      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: const Color(0xFF4C6FFF),
          handleColor: const Color(0xFF4C6FFF),
          backgroundColor: Colors.grey[800]!,
          bufferedColor: Colors.grey[600]!,
        ),
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4C6FFF))),
          ),
        ),
      );

      _isInitialized.value = true;
    } catch (e) {
      debugPrint('Error initializing video player: $e');
      _errorMessage.value = 'Failed to load video: $e';

      // Auto close after showing error
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _isInitialized.dispose();
    _errorMessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Video Playback', style: TextStyle(color: Colors.white)),
      ),
      body: ValueListenableBuilder<String?>(
        valueListenable: _errorMessage,
        builder: (context, error, _) {
          if (error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ValueListenableBuilder<bool>(
            valueListenable: _isInitialized,
            builder: (context, isInitialized, _) {
              return Center(
                child: isInitialized && _chewieController != null
                    ? Chewie(controller: _chewieController!)
                    : const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4C6FFF))),
              );
            },
          );
        },
      ),
    );
  }
}
