# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [4.4.4+1] - 2025-01-27

### Added
- Enhanced UI with modern Material Design principles
- Real-time audio level visualization with animated waveforms
- Pulsing animations for record and play buttons
- Beautiful gradient backgrounds and shadows
- Responsive layout that works on all screen sizes
- Comprehensive documentation with examples
- Support for all major platforms (Android, iOS, Web, Windows, macOS, Linux)

### Changed
- Updated package name to `record_4_4_4_fix`
- Improved example app with modern UI components
- Enhanced audio player with better visual feedback
- Updated README with comprehensive documentation
- Fixed all linting issues and deprecated API usage

### Fixed
- Package export issues
- Deprecated `withOpacity` usage replaced with `withValues`
- Linting warnings and errors
- Import path corrections

### Technical Details
- Flutter SDK: >=2.8.1
- Dart SDK: >=2.15.1 <3.0.0
- All platforms supported with feature parity matrix
- Multiple audio encoders supported
- Real-time amplitude monitoring
- Pause/resume functionality
- Input device selection

## [4.4.4] - Original Version

### Features
- Basic audio recording functionality
- Multiple codec support
- Cross-platform compatibility
- Simple API interface

### Platforms
- Android (MediaRecorder)
- iOS (AVAudioRecorder)
- Web (Browser APIs)
- Windows (fmedia)
- macOS (AVCaptureSession)
- Linux (fmedia)