library;

import 'isolate_svg_renderer.dart';

export 'services/isolate_svg_service.dart';
export 'config/renderer_config.dart';
export 'widgets/isolate_svg_loader.dart';

SvgRendererConfig _config = const SvgRendererConfig();

void initializeRenderer({SvgRendererConfig? config}) {
  _config = config ?? const SvgRendererConfig();
}

SvgRendererConfig get rendererConfig => _config;
