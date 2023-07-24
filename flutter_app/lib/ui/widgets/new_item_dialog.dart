import 'dart:io';

import 'package:appium_demo/models/record_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class NewItemDialog extends StatefulWidget {
  const NewItemDialog({super.key});

  static Future<RecordModel?> showModal(BuildContext context) async {
    return await showDialog<RecordModel?>(
      context: context,
      builder: (context) => const NewItemDialog(),
    );
  }

  @override
  State<NewItemDialog> createState() => _NewItemDialogState();
}

class _NewItemDialogState extends State<NewItemDialog> {
  final TextEditingController titleController = TextEditingController();
  File? pickedFile;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить запись'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Название'),
          ),
          const SizedBox(height: 12.0),
          OutlinedButton(
            onPressed: pickFile,
            child: Text(pickedFile == null ? 'Выбрать файл' : 'Файл выбран'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Закрыть'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FilledButton(
          onPressed: titleController.text.isEmpty && pickedFile == null
              ? null
              : () => Navigator.of(context).pop(RecordModel(
                    title: titleController.text,
                    image: pickedFile!,
                  )),
          child: const Text('Сохранить'),
        ),
      ],
    );
  }

  Function()? onSavePressed() {
    if (titleController.text.isEmpty && pickedFile == null) return null;
    return () => Navigator.of(context).pop(RecordModel(
          title: titleController.text,
          image: pickedFile!,
        ));
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result?.files.single.path == null) return;
    setState(() => pickedFile = File(result!.files.single.path!));
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }
}
