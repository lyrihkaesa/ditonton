import 'package:flutter/material.dart';

class ContainerImageErrorHome extends StatelessWidget {
  const ContainerImageErrorHome();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 133,
      color: Colors.grey,
      child: const Icon(Icons.error),
    );
  }
}

class ContainerImageError extends StatelessWidget {
  const ContainerImageError();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      color: Colors.grey,
      child: const Icon(Icons.error),
    );
  }
}
