// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingScreen();
    },
  );
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}

/// generated route for
/// [ThankYouScreen]
class ThankYouRoute extends PageRouteInfo<void> {
  const ThankYouRoute({List<PageRouteInfo>? children})
    : super(ThankYouRoute.name, initialChildren: children);

  static const String name = 'ThankYouRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ThankYouScreen();
    },
  );
}

/// generated route for
/// [VideoPlayerScreen]
class VideoPlayerRoute extends PageRouteInfo<VideoPlayerRouteArgs> {
  VideoPlayerRoute({
    Key? key,
    required String videoPath,
    List<PageRouteInfo>? children,
  }) : super(
         VideoPlayerRoute.name,
         args: VideoPlayerRouteArgs(key: key, videoPath: videoPath),
         initialChildren: children,
       );

  static const String name = 'VideoPlayerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VideoPlayerRouteArgs>();
      return VideoPlayerScreen(key: args.key, videoPath: args.videoPath);
    },
  );
}

class VideoPlayerRouteArgs {
  const VideoPlayerRouteArgs({this.key, required this.videoPath});

  final Key? key;

  final String videoPath;

  @override
  String toString() {
    return 'VideoPlayerRouteArgs{key: $key, videoPath: $videoPath}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VideoPlayerRouteArgs) return false;
    return key == other.key && videoPath == other.videoPath;
  }

  @override
  int get hashCode => key.hashCode ^ videoPath.hashCode;
}
