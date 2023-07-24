import 'package:appium_demo/models/record_model.dart';
import 'package:flutter/material.dart';

class RecordCard extends StatelessWidget {
  final RecordModel record;

  const RecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(children: [
        Padding(
          padding: padding,
          child: buildTopRow(context),
        ),
        buildImage(),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: padding,
            child: buildSearchButton(),
          ),
        ),
      ]),
    );
  }

  Widget buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          record.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete_rounded),
        )
      ],
    );
  }

  Widget buildImage() {
    return AspectRatio(
      aspectRatio: 2,
      child: Image.file(
        record.image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildSearchButton() {
    return FilledButton.tonal(
      onPressed: () {},
      child: const Text('Filled tonal'),
    );
  }
}
