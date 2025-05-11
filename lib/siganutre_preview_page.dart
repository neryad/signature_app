import 'dart:io';

import 'package:flutter/material.dart';

class SignaturePreviewPage extends StatelessWidget {
  final String path;
  const SignaturePreviewPage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vista de la firma')),
      body: Center(
        child: Column(
          children: [
            Image.file(File(path)),
            SizedBox(height: 20),
            Text('Firma guardada en: $path'),
            Padding(padding: EdgeInsets.all(20), child: Text(path)),
          ],
        ),
      ),
    );
  }
}
