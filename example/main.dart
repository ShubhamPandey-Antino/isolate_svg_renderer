import 'package:flutter/material.dart';
import 'package:isolate_svg_renderer/isolate_svg_renderer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: IsolateSvgLoader(assetPath: 'assets/large_image.svg'),
        ),
      ),
    );
  }
}
