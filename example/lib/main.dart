import 'package:flutter/material.dart';
import 'package:netio/netio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () async {
              final response = await Netio()
                  .get('https://jsonplaceholder.typicode.com/posts');
              print(response);
            },
            child: const Text('Netio Get')),
        TextButton(
            onPressed: () async {
              final response = await Netio()
                  .post('https://jsonplaceholder.typicode.com/posts');
              print(response);
            },
            child: const Text('Netio Post')),
      ],
    );
  }
}
