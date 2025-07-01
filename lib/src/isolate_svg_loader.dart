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
    return FutureBuilder(
      future: _loadSvg(assetPath,context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: const Icon(Icons.error));
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


  Future<String> _loadSvg(String assetPath,BuildContext context) async {
    final cached = SvgCache.get(assetPath);
    if (cached != null) return cached;

    final rawSvg = await DefaultAssetBundle.of(context).loadString(assetPath);
    final optimized = await preprocessSvgInIsolate(rawSvg);

    SvgCache.set(assetPath, optimized);
    return optimized;
  }

}
