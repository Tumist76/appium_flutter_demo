import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.list_rounded, size: 48),
        SizedBox(height: 15.0),
        Text('Записей пока нет'),
      ],
    );
  }
}
