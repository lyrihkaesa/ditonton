import 'package:flutter/material.dart';

class ContainerImageErrorHome extends StatelessWidget {
  const ContainerImageErrorHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 133,
      color: Colors.grey,
      child: Icon(Icons.error),
    );
  }
}

class ContainerImageError extends StatelessWidget {
  const ContainerImageError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      color: Colors.grey,
      child: Icon(Icons.error),
    );
  }
}
