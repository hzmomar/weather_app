import 'package:flutter/material.dart';
import 'package:teleport_air_asia/ui/shared/theme_color.dart';

class WeatherIcon extends StatelessWidget {
  final String? pngPath;
  final Size? size;

  const WeatherIcon({
    required this.pngPath,
    this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      pngPath ?? '',
      width: size?.width ?? 40,
      height: size?.height ?? 40,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (_, __, ___) {
        return const Icon(
          Icons.warning_amber_outlined,
          size: 20,
          color: ThemeColor.shade50,
        );
      },
    );
  }
}