import 'package:databases/database_helper/database_helper.dart';
import 'package:databases/database_helper/database_helper_config.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
                  return Text('${(entries[index] as EntryModel).id} : ${(entries[index] as EntryModel).age}');
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
          helper.insert(
            EntryModel(
              id: DateTime.now().millisecond,
              age: 10
            )
          ).whenComplete(() { setState(() {}); });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
