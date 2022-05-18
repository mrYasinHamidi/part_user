import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final String? path;

  const ImageViewer({Key? key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (path != null) {
      return Image.network(
        path!,
        fit: BoxFit.cover,
      );
    }
    return const Icon(Icons.broken_image);
  }
}
