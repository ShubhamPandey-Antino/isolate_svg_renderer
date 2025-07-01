import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../cache/svg_cache.dart';
import '../services/isolate_svg_service.dart';

class IsolateSvgWidget extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;

  const IsolateSvgWidget({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadSvg(context),
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

  Future<String> _loadSvg(BuildContext context) async {
    final cached = SvgCache.get(assetPath);
    if (cached != null) return cached;

    final inProgress = SvgCache.getProcessing(assetPath);
    if (inProgress != null) return inProgress;

    final rawSvg = await DefaultAssetBundle.of(context).loadString(assetPath);
    final future = preprocessSvgInIsolate(rawSvg);
    SvgCache.setProcessing(assetPath, future);
    final optimized = await future;
    SvgCache.set(assetPath, optimized);
    return optimized;
  }
}
