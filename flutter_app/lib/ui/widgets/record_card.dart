import 'package:appium_demo/models/record_model.dart';
import 'package:appium_demo/ui/screens/webview_screen.dart';
import 'package:flutter/material.dart';

class RecordCard extends StatelessWidget {
  final RecordModel record;
  final VoidCallback onDeleteTapped;

  const RecordCard({
    super.key,
    required this.record,
    required this.onDeleteTapped,
  });

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
            child: buildSearchButton(context),
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
          onPressed: onDeleteTapped,
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

  Widget buildSearchButton(BuildContext context) {
    return FilledButton.tonal(
      onPressed: () => search(context),
      child: const Text('Найти в Wikipedia'),
    );
  }

  Future<void> search(BuildContext context) async {
    final searchUrl =
        'https://ru.wikipedia.org/w/index.php?search=${record.title}';
    await Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) => WebViewScreen(url: Uri.parse(searchUrl)),
    ));
  }
}
