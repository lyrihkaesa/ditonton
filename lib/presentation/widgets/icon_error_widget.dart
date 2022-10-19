import 'package:flutter/material.dart';

class IconErrorWidget extends StatelessWidget {
  const IconErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.grey,
      child: Center(
        child: Icon(Icons.error),
      ),
    );
  }
}
