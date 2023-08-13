import 'package:flutter/material.dart';

import '../data/file_item.dart';
import 'edited_text_screen.dart';


class MyFilesScreen extends StatefulWidget {
  const MyFilesScreen({Key? key}) : super(key: key);

  @override
  State<MyFilesScreen> createState() => _MyFilesScreenState();
}

class _MyFilesScreenState extends State<MyFilesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Files',style: Theme.of(context).textTheme.bodyLarge,),
      ),
      body: ListView.separated(
        itemCount: fileItems.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          final file = fileItems[index];
          return ListTile(
            title: Text(file.header),
            subtitle: Text(file.text,maxLines: 1,overflow: TextOverflow.ellipsis,),
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
