import 'package:flutter/material.dart';

import '../data/file_item.dart';
import 'edited_text_screen.dart';

class MyFilesScreen extends StatefulWidget {
  const MyFilesScreen({Key? key}) : super(key: key);

  @override
  State<MyFilesScreen> createState() => _MyFilesScreenState();
}

class _MyFilesScreenState extends State<MyFilesScreen> {
  final List<FileItem> files = [
    FileItem(
      id: 1,
      header: 'Dosya Başlığı 1',
      text: 'Bu dosya hakkında metin 1.',
      editor: 'Dosya Editörü 1',
    ),
    FileItem(
      id: 2,
      header: 'Dosya Başlığı 2',
      text: 'Bu dosya hakkında metin 2.',
      editor: 'Dosya Editörü 2',
    ),
    // Diğer dosyaları burada ekleyebilirsiniz.
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Files'),
      ),
      body: ListView.separated(
        itemCount: files.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          final file = files[index];
          return ListTile(
            title: Text(file.header),
            subtitle: Text(file.text),
            trailing: Text(file.editor),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditedTextScreen(editedText: file.text, header: file.header, editor: file.editor),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
