import 'package:flutter/foundation.dart';

/// Basic SVG string optimizer — runs in an isolate
String preprocessSvg(String rawSvg) {
  return rawSvg
      .replaceAll(RegExp(r'<!--.*?-->'), '') // remove comments
      .replaceAll('\n', '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

/// Runs the above in a separate isolate
Future<String> preprocessSvgInIsolate(String rawSvg) async {
  return compute(preprocessSvg, rawSvg);
}
