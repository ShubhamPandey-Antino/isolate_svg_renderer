/// A simple in-memory cache for optimized SVG strings.
class SvgCache {
  static final Map<String, String> _cache = {};

  static String? get(String key) => _cache[key];

  static void set(String key, String value) => _cache[key] = value;

  static void clear() => _cache.clear();
}
