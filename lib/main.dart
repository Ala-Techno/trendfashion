import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: Te(),
    );
  }
}

class Te extends StatelessWidget {
  const Te({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ddk'),
        centerTitle: true,
        leading: Icon(Icons.dangerous),
        backgroundColor: Colors.amber,
      ),
      body: Text('ks'),
    );
  }
}
