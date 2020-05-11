import 'package:flutter/material.dart';

class loadingScreen extends StatelessWidget {
  static const id='loadingScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
