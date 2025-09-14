import 'dart:async';

import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AudioPlayer extends StatefulWidget {
  /// Path from where to play recorded audio
  final String source;

  /// Callback when audio file should be removed
  /// Setting this to null hides the delete button
  final VoidCallback onDelete;

  const AudioPlayer({
    Key? key,
    required this.source,
    required this.onDelete,
  }) : super(key: key);

  @override
  AudioPlayerState createState() => AudioPlayerState();
}

class AudioPlayerState extends State<AudioPlayer> with TickerProviderStateMixin {
  static const double _controlSize = 80;
  static const double _deleteBtnSize = 32;

  final _audioPlayer = ap.AudioPlayer();
  late StreamSubscription<void> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  Duration? _position;
  Duration? _duration;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _playerStateChangedSubscription =
        _audioPlayer.onPlayerComplete.listen((state) async {
      await stop();
      setState(() {});
    });
    
    _positionChangedSubscription = _audioPlayer.onPositionChanged.listen(
      (position) => setState(() {
        _position = position;
      }),
    );
    
    _durationChangedSubscription = _audioPlayer.onDurationChanged.listen(
      (duration) => setState(() {
        _duration = duration;
      }),
    );
  }

  @override
  void dispose() {
    _playerStateChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    _pulseController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            children: [
              const Icon(
                Icons.audiotrack,
                color: Colors.deepPurple,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Audio Player',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  stop().then((value) => widget.onDelete());
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 24,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.1),
                  shape: const CircleBorder(),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Control and Progress
          Row(
            children: [
              _buildControl(),
              const SizedBox(width: 24),
              Expanded(child: _buildProgressSection()),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Time Display
          _buildTimeDisplay(),
        ],
      ),
    );
  }

  Widget _buildControl() {
    Icon icon;
    Color backgroundColor;

    if (_audioPlayer.state == ap.PlayerState.playing) {
      icon = const Icon(Icons.pause, color: Colors.white, size: 32);
      backgroundColor = Colors.red;
    } else {
      icon = const Icon(Icons.play_arrow, color: Colors.white, size: 32);
      backgroundColor = Colors.deepPurple;
    }

    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _audioPlayer.state == ap.PlayerState.playing ? _pulseAnimation.value : 1.0,
          child: Container(
            width: _controlSize,
            height: _controlSize,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: backgroundColor.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(_controlSize / 2),
                onTap: () {
                  if (_audioPlayer.state == ap.PlayerState.playing) {
                    pause();
                  } else {
                    play();
                  }
                },
                child: Center(child: icon),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSlider(),
        const SizedBox(height: 8),
        _buildTimeDisplay(),
      ],
    );
  }

  Widget _buildSlider() {
    bool canSetValue = false;
    final duration = _duration;
    final position = _position;

    if (duration != null && position != null) {
      canSetValue = position.inMilliseconds > 0;
      canSetValue &= position.inMilliseconds < duration.inMilliseconds;
    }

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.deepPurple,
        inactiveTrackColor: Colors.deepPurple.withOpacity(0.2),
        thumbColor: Colors.deepPurple,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        trackHeight: 4,
      ),
      child: Slider(
        onChanged: (v) {
          if (duration != null) {
            final position = v * duration.inMilliseconds;
            _audioPlayer.seek(Duration(milliseconds: position.round()));
          }
        },
        value: canSetValue && duration != null && position != null
            ? position.inMilliseconds / duration.inMilliseconds
            : 0.0,
      ),
    );
  }

  Widget _buildTimeDisplay() {
    final duration = _duration;
    final position = _position;

    if (duration == null) {
      return const Text(
        '00:00 / 00:00',
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFF718096),
          fontFamily: 'monospace',
        ),
      );
    }

    final positionStr = _formatDuration(position ?? Duration.zero);
    final durationStr = _formatDuration(duration);

    return Text(
      '$positionStr / $durationStr',
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF718096),
        fontFamily: 'monospace',
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  Future<void> play() async {
    await _audioPlayer.play(
      kIsWeb ? ap.UrlSource(widget.source) : ap.DeviceFileSource(widget.source),
    );
    _pulseController.repeat(reverse: true);
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    _pulseController.stop();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _pulseController.stop();
  }
}