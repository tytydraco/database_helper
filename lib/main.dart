import 'package:databases/database_helper.dart';
import 'package:databases/database_helper_config.dart';
import 'package:databases/entry.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Database Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Database Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

DatabaseHelper helper = DatabaseHelper(
  DatabaseHelperConfig()
);

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: helper.retrieve(EntryModel.fromMap),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final entries = snapshot.data as List<DatabaseModel>;
              return ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index] as EntryModel;
                  return Text('${entry.id}\t${entry.content}');
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final timeNow = DateTime.now();
          helper.insert(
            EntryModel(
              id: timeNow.millisecondsSinceEpoch,
              content: timeNow.toIso8601String(),
            )
          ).whenComplete(() { setState(() {}); });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
