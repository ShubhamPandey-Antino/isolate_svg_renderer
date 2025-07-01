import 'package:flutter/foundation.dart';

class SvgRendererConfig {
  final bool enableCache;
  final Duration timeout;

  const SvgRendererConfig({
    this.enableCache = true,
    this.timeout = const Duration(seconds: 10),
  });
}
