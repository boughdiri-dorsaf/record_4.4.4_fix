# Record 4.4.4 Fix

[![pub package](https://img.shields.io/pub/v/record_4_4_4_fix.svg)](https://pub.dev/packages/record_4_4_4_fix)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter audio recording plugin with enhanced UI and improved functionality. This is a fixed and improved version of the original record plugin with modern UI components and better user experience.

## ✨ Features

- 🎤 **High-Quality Audio Recording** - Record audio with multiple codecs and bit rates
- 🎨 **Modern UI** - Beautiful, responsive interface with animations and visual feedback
- 📱 **Cross-Platform** - Works on Android, iOS, Web, Windows, macOS, and Linux
- ⏸️ **Pause/Resume** - Full control over recording sessions
- 📊 **Real-time Visualization** - Live audio level monitoring with waveform display
- 🔧 **Customizable** - Multiple encoding options, bit rates, and sampling rates
- 🎯 **Easy Integration** - Simple API with comprehensive documentation

## 🚀 Quick Start

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  record_4_4_4_fix: ^4.4.4
```

### Basic Usage

```dart
import 'package:record_4_4_4_fix/record.dart';

final record = Record();

// Check and request permission
if (await record.hasPermission()) {
  // Start recording
  await record.start(
    path: 'aFullPath/myFile.m4a',
    encoder: AudioEncoder.aacLc, // by default
    bitRate: 128000, // by default
    sampleRate: 44100, // by default
  );
}

// Get the state of the recorder
bool isRecording = await record.isRecording();

// Stop recording
await record.stop();
```

## 📱 Platform Support

### Android
- **Min SDK**: 19
- **Permissions**: `RECORD_AUDIO`, `WRITE_EXTERNAL_STORAGE` (optional)
- **Encoders**: AAC LC, AAC ELD, AAC HE, AMR NB, AMR WB, Opus, PCM 8-bit, PCM 16-bit

### iOS
- **Min SDK**: 11.0
- **Permissions**: `NSMicrophoneUsageDescription`
- **Encoders**: AAC LC, AAC ELD, AAC HE, AMR NB, AMR WB, Opus, FLAC, PCM 8-bit, PCM 16-bit

### Web
- **Browser Support**: Chrome, Firefox, Safari, Edge
- **Encoders**: Opus OGG (browser-dependent)

### Windows
- **Dependencies**: fmedia
- **Encoders**: AAC LC, AAC HE, Opus, Vorbis OGG, WAV, FLAC

### macOS
- **Min SDK**: 10.15
- **Permissions**: `NSMicrophoneUsageDescription`
- **Encoders**: AAC LC, AAC ELD, AAC HE, Opus, Vorbis OGG, WAV, FLAC, PCM 8-bit, PCM 16-bit

### Linux
- **Dependencies**: fmedia (must be installed separately)
- **Encoders**: AAC LC, AAC HE, Opus, Vorbis OGG, WAV, FLAC

## 🎨 Enhanced UI Features

### Modern Design
- Clean, minimalist interface with Material Design principles
- Smooth animations and transitions
- Responsive layout that works on all screen sizes
- Dark/light theme support

### Real-time Feedback
- Live audio level visualization with animated waveforms
- Pulsing record button during recording
- Color-coded status indicators
- Progress tracking with time display

### User Experience
- Intuitive controls with clear visual feedback
- Smooth pause/resume functionality
- Easy file management and playback
- Error handling with user-friendly messages

## 📋 API Reference

### Record Class

#### Methods

| Method | Description | Return Type |
|--------|-------------|-------------|
| `start()` | Start recording audio | `Future<void>` |
| `stop()` | Stop recording and return file path | `Future<String?>` |
| `pause()` | Pause current recording | `Future<void>` |
| `resume()` | Resume paused recording | `Future<void>` |
| `isRecording()` | Check if currently recording | `Future<bool>` |
| `hasPermission()` | Check microphone permission | `Future<bool>` |
| `isEncoderSupported()` | Check if encoder is supported | `Future<bool>` |
| `listInputDevices()` | List available input devices | `Future<List<InputDevice>>` |

#### Streams

| Stream | Description | Type |
|--------|-------------|------|
| `onStateChanged()` | Listen to recording state changes | `Stream<RecordState>` |
| `onAmplitudeChanged()` | Listen to audio amplitude changes | `Stream<Amplitude>` |

### AudioEncoder Enum

```dart
enum AudioEncoder {
  aacLc,      // AAC Low Complexity
  aacEld,     // AAC Enhanced Low Delay
  aacHe,      // AAC High Efficiency
  amrNb,      // AMR Narrow Band
  amrWb,      // AMR Wide Band
  opus,       // Opus
  vorbisOgg,  // Vorbis OGG
  wav,        // WAV
  flac,       // FLAC
  pcm8bit,    // PCM 8-bit
  pcm16bit,   // PCM 16-bit
}
```

### RecordState Enum

```dart
enum RecordState {
  stop,       // Not recording
  record,     // Currently recording
  pause,      // Recording paused
}
```

## 🔧 Configuration

### Android Permissions

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<!-- Optional, for external storage access -->
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

### iOS Permissions

Add to `ios/Runner/Info.plist`:

```xml
<key>NSMicrophoneUsageDescription</key>
<string>We need to access to the microphone to record audio file</string>
```

### macOS Permissions

Add to `macos/Runner/Info.plist`:

```xml
<key>NSMicrophoneUsageDescription</key>
<string>We need to access to the microphone to record audio file</string>
```

And activate "Audio input" in capabilities for both debug and release schemes.

## 📊 Platform Feature Matrix

| Feature | Android | iOS | Web | Windows | macOS | Linux |
|---------|---------|-----|-----|---------|-------|-------|
| Pause/Resume | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Amplitude (dBFS) | ✅ | ✅ | ❌ | ❌ | ✅ | ❌ |
| Permission Check | ✅ | ✅ | ✅ | ❌ | ✅ | ❌ |
| Multiple Channels | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Device Selection | ❌ | Auto BT/mic | ✅ | ✅ | ✅ | ✅ |

## 🎵 Encoder Support Matrix

| Encoder | Android | iOS | Web | Windows | macOS | Linux |
|---------|---------|-----|-----|---------|-------|-------|
| AAC LC | ✅ | ✅ | ❓ | ✅ | ✅ | ✅ |
| AAC ELD | ✅ | ✅ | ❓ | ❌ | ✅ | ❌ |
| AAC HE | ✅ | ✅ | ❓ | ✅ | ✅ | ✅ |
| AMR NB | ✅ | ✅ | ❓ | ❌ | ✅ | ❌ |
| AMR WB | ✅ | ✅ | ❓ | ❌ | ✅ | ❌ |
| Opus | ✅ | ✅ | ❓ | ✅ | ✅ | ✅ |
| Vorbis OGG | ❓ | ❌ | ❓ | ✅ | ❌ | ✅ |
| WAV | ✅ | ❌ | ❓ | ✅ | ❌ | ✅ |
| FLAC | ❌ | ✅ | ❓ | ✅ | ✅ | ✅ |
| PCM 8-bit | ✅ | ✅ | ❓ | ❌ | ✅ | ❌ |
| PCM 16-bit | ✅ | ✅ | ❓ | ❌ | ✅ | ❌ |

## 🛠️ Advanced Usage

### Custom Recording Configuration

```dart
await record.start(
  path: '/path/to/recording.m4a',
  encoder: AudioEncoder.aacLc,
  bitRate: 256000,        // Higher quality
  sampleRate: 48000,      // Professional sample rate
  numChannels: 2,         // Stereo recording
);
```

### Real-time Amplitude Monitoring

```dart
record.onAmplitudeChanged(const Duration(milliseconds: 100))
  .listen((amplitude) {
    print('Current: ${amplitude.current} dB');
    print('Max: ${amplitude.max} dB');
  });
```

### Input Device Selection

```dart
final devices = await record.listInputDevices();
final selectedDevice = devices.firstWhere(
  (device) => device.name.contains('USB'),
);

await record.start(
  path: '/path/to/recording.m4a',
  device: selectedDevice,
);
```

## 🐛 Troubleshooting

### Common Issues

1. **Permission Denied**
   - Ensure microphone permissions are properly configured
   - Check platform-specific permission requirements

2. **Encoder Not Supported**
   - Verify encoder compatibility with your target platform
   - Use fallback encoders (AAC LC is widely supported)

3. **File Path Issues**
   - Use absolute paths for better compatibility
   - Ensure directory exists before recording

4. **Audio Quality Issues**
   - Adjust bit rate and sample rate settings
   - Check device microphone quality

### Debug Mode

Enable debug logging to troubleshoot issues:

```dart
if (kDebugMode) {
  print('Recording state: ${await record.isRecording()}');
  print('Has permission: ${await record.hasPermission()}');
}
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Original record plugin by [llfbandit](https://github.com/llfbandit/record)
- Flutter team for the amazing framework
- Community contributors and testers

## 📞 Support

If you encounter any issues or have questions:

- 📧 Create an issue on [GitHub](https://github.com/boughdiri-dorsaf/record_4.4.4_fix/issues)
- 📖 Check the [documentation](https://pub.dev/packages/record_4_4_4_fix)
- 💬 Join our community discussions

---

Made with ❤️ by the Flutter community