import 'package:flutter/material.dart';

class ImageViewPage extends StatelessWidget {
  final String imageUrl;

  ImageViewPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image View'),
      ),
      body: Center(
        child: Image.network(
          imageUrl,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Text('Error loading image');
          },
        ),
      ),
    );
  }
}
