import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotspot_hosts/config/assets/colors.gen.dart';
import 'package:hotspot_hosts/features/onboarding/controller/onboarding_state_notifier.dart';

class TextInputPageWidget extends ConsumerStatefulWidget {
  final Map<String, dynamic> question;
  final VoidCallback onNext;

  const TextInputPageWidget({super.key, required this.question, required this.onNext});

  @override
  ConsumerState<TextInputPageWidget> createState() => _TextInputPageWidgetState();
}

class _TextInputPageWidgetState extends ConsumerState<TextInputPageWidget> {
  final TextEditingController _textController = TextEditingController();
  final ValueNotifier<bool> _isRecordingNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _textController.dispose();
    _isRecordingNotifier.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    _isRecordingNotifier.value = !_isRecordingNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isRecordingNotifier,
      builder: (context, isRecording, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildTextInputArea(),
            if (isRecording) _buildRecordingSection(),
            _buildBottomActions(isRecording),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question['question'],
            style: const TextStyle(color: AppColors.white, fontSize: 24, fontWeight: FontWeight.w600),
          ),
          if (widget.question['subtitle'] != null) ...[
            const SizedBox(height: 8),
            Text(widget.question['subtitle'], style: TextStyle(color: Colors.grey[400], fontSize: 14)),
          ],
        ],
      ),
    );
  }

  Widget _buildTextInputArea() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(8)),
          child: TextField(
            controller: _textController,
            onChanged: (value) {
              ref.read(onboardingStateNotifierProvider.notifier).updateDescription(value);
            },
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            style: const TextStyle(color: AppColors.white, fontSize: 16),
            decoration: InputDecoration(
              hintText: widget.question['placeholder'],
              hintStyle: TextStyle(color: Colors.grey[600]),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecordingSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                _isRecordingNotifier.value = false;
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                child: const Icon(Icons.stop, color: AppColors.white, size: 20),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomPaint(size: const Size(double.infinity, 40), painter: WaveformPainter()),
            ),
            const SizedBox(width: 12),
            const Text('00:47', style: TextStyle(color: AppColors.white, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions(bool isRecording) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          _buildMicrophoneButton(isRecording),
          const SizedBox(width: 12),
          _buildCameraButton(),
          const SizedBox(width: 12),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildMicrophoneButton(bool isRecording) {
    return GestureDetector(
      onTap: _toggleRecording,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[800]!),
        ),
        child: Icon(isRecording ? Icons.stop : Icons.mic, color: AppColors.white),
      ),
    );
  }

  Widget _buildCameraButton() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: const Icon(Icons.videocam, color: AppColors.white),
    );
  }

  Widget _buildNextButton() {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: widget.onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey[800]!),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Next',
                style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: AppColors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Painter for Waveform
class WaveformPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const barCount = 40;
    final barWidth = size.width / barCount;

    for (int i = 0; i < barCount; i++) {
      final height = (i % 3 == 0) ? size.height * 0.8 : size.height * 0.4;
      final x = i * barWidth + barWidth / 2;

      canvas.drawLine(Offset(x, size.height / 2 - height / 2), Offset(x, size.height / 2 + height / 2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
