import 'package:appium_demo/models/record_model.dart';
import 'package:appium_demo/ui/widgets/record_card.dart';
import 'package:appium_demo/ui/widgets/new_item_dialog.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final records = <RecordModel>[];

  Future<void> _incrementCounter() async {
    final newRecord = await NewItemDialog.showModal(context);
    if (newRecord == null) return;
    setState(() => records.add(newRecord));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Appium Demo'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (_, index) => RecordCard(record: records[index]),
    );
  }
}
