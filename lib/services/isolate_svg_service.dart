import 'package:flutter/foundation.dart';

String preprocessSvg(String rawSvg) {
  return rawSvg
      .replaceAll(RegExp(r'<!--.*?-->'), '') // remove comments
      .replaceAll('\n', '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

Future<String> preprocessSvgInIsolate(String rawSvg) async {
  return compute(preprocessSvg, rawSvg);
}
