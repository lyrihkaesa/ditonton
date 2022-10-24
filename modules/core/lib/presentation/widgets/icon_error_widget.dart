import 'package:flutter/material.dart';

class IconErrorWidget extends StatelessWidget {
  const IconErrorWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.grey,
      child: const Center(
        child: Icon(Icons.error),
      ),
    );
  }
}
