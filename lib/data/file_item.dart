class FileItem {
  final String id;
  final String header;
  final String text;
  final String editor;

  FileItem({
    required this.id,
    required this.header,
    required this.text,
    required this.editor,
  });
}

final List<FileItem> fileItems = [
  FileItem(
    id: "1",
    header: "Header 1",
    text: "Text 1",
    editor: "Editor 1",
  ),
  FileItem(
    id: "2",
    header: "Header 2",
    text: "Text 2",
    editor: "Editor 2",
  ),
  // Diğer öğeleri burada ekleyebilirsiniz
];