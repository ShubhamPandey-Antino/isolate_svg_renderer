/// svg_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isolate_svg_renderer/src/svg_cache.dart';
import 'svg_processor.dart';

class IsolateSvgLoader extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;

  const IsolateSvgLoader({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadSvg(assetPath, context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: width,
            height: height,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return SizedBox(
            width: width,
            height: height,
            child: const Center(child: Icon(Icons.error)),
          );
        } else {
          return SvgPicture.string(
            snapshot.data!,
            width: width,
            height: height,
          );
        }
      },
    );
  }

  Future<String> _loadSvg(String assetPath, BuildContext context) async {
    // Check if already cached
    final cached = SvgCache.get(assetPath);
    if (cached != null) return cached;

    // Check if already being processed
    final inProgress = SvgCache.getProcessing(assetPath);
    if (inProgress != null) return inProgress;

    // Start new isolate task and cache it
    final rawSvg = await DefaultAssetBundle.of(context).loadString(assetPath);
    final future = preprocessSvgInIsolate(rawSvg);

    SvgCache.setProcessing(assetPath, future);

    final optimized = await future;
    SvgCache.set(assetPath, optimized);
    return optimized;
  }
}
