import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:scan/data/file_item.dart';
import 'package:uuid/uuid.dart';

import 'edited_text_screen.dart';

class ResultScreen extends StatefulWidget {
  final String text;

  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  quill.QuillController _controller = quill.QuillController.basic();

  @override
  void initState() {
    super.initState();
    _controller = quill.QuillController.basic()
      ..document.insert(0, widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
                width: MediaQuery.of(context).size.width,
                height: 10,
              ),
              Card(
                elevation: 8,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(boxShadow: []),
                      child: quill.QuillEditor.basic(
                          controller: _controller, readOnly: false),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                  ),
                  onPressed: () {
                    fileItems.add(FileItem(
                        id: Uuid().v4(),
                        header: 'Yeni Dosya',
                        editor: 'user',
                        text: _controller.document.toPlainText()));
                  },
                  child: Text('Kaydet', style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
