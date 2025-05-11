import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:signature_app/siganutre_preview_page.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({super.key});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firma digital')),
      body: Column(
        children: [
          Expanded(
            child: Signature(
              controller: _controller,
              backgroundColor: Colors.grey,
            ),
          ),
          buildButtons(),
        ],
      ),
    );
  }

  buildButtons() {
    return Container(
      color: Colors.grey[200],
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                _controller.clear();
              });
            },
            icon: Icon(Icons.clear),
          ),

          IconButton(
            onPressed: () async {
              if (_controller.isNotEmpty) {
                await exportSignature();
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
    );
  }

  Future<void> exportSignature() async {
    final ui.Image? data = await _controller.toImage();
    final directory = await getApplicationDocumentsDirectory();

    final String path = '${directory.path}/signature.png';

    final File file = File(path);

    final byteData = await data?.toByteData(format: ui.ImageByteFormat.png);

    await file.writeAsBytes(byteData!.buffer.asInt8List());

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Firma guardada en $path')));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignaturePreviewPage(path: path)),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _controller.dispose();
  }
}
