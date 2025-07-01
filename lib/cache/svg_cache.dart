/// svg_cache.dart
class SvgCache {
  static final Map<String, String> _cache = {};
  static final Map<String, Future<String>> _processing = {};

  static String? get(String key) => _cache[key];

  static void set(String key, String value) {
    _cache[key] = value;
    _processing.remove(key); // Remove from in-progress
  }

  static Future<String>? getProcessing(String key) => _processing[key];

  static void setProcessing(String key, Future<String> future) {
    _processing[key] = future;
  }

  static void clear() {
    _cache.clear();
    _processing.clear();
  }
}
