import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Not Defteri',
      theme: ThemeData(),
      home: const NotepadListScreen(),
    );
  }
}

class NotepadListScreen extends StatefulWidget {
  const NotepadListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NotepadListState();
}

class NotepadListState extends State<NotepadListScreen> {
  final List<NotepadListItem> _notes = <NotepadListItem>[];
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _noteTextController = TextEditingController();

  void _handlePressed(String title, String body) {
    _titleTextController.clear();
    _noteTextController.clear();
    NotepadListItem item = NotepadListItem(
      title: title,
      body: body,
      onDelete: () => _handleDelete(_notes.length - 1),
    );
    setState(() {
      _notes.add(item);
    });
    Navigator.of(context).pop();
  }

  void _handleDelete(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  void _pushNewNote() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Yeni Not'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: _titleTextController,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF737171),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Başlık',
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF737171),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _noteTextController,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF737171),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Not',
                    hintStyle: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF737171),
                    ),
                  ),
                  maxLines: null,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                _handlePressed(_titleTextController.text, _noteTextController.text),
            child: const Icon(Icons.check),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Not Defteri',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (_, int index) =>
        _notes[index],
        itemCount: _notes.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushNewNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NotepadListItem extends StatelessWidget {
  const NotepadListItem(
      {Key? key,
        required this.title,
        required this.body,
        required this.onDelete})
      : super(key: key);

  final String title;
  final String body;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightGreen,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              body,
              style: const TextStyle(fontSize: 18.0, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
