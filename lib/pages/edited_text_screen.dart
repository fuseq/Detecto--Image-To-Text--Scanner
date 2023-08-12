import 'package:flutter/material.dart';

class EditedTextScreen extends StatefulWidget {
  final String editedText;
  final String header;
  final String editor;

  const EditedTextScreen({Key? key, required this.editedText, required this.header, required this.editor}) : super(key: key);

  @override
  State<EditedTextScreen> createState() => _EditedTextScreenState();
}

class _EditedTextScreenState extends State<EditedTextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.header, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 10),
            Card(
              elevation: 8,
              child: Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width ,
                child: Text(widget.editedText))),
          ],
        ),
      ),
    );
  }
}

