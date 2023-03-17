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
    return Scaffold(
      appBar: AppBar(title: const Text("Netio")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () async {
                  final response = await Netio().get(
                      'https://jsonplaceholder.typicode.com/posts',
                      options: Options(
                          maxRedirects: 2,
                          idleTimeout: const Duration(seconds: 10)));
                  print(response?.body);
                  print(response?.options?.contentLength);
                  print(response?.options?.method);
                  print(response?.errorMessage);
                  print(response?.statusCode);
                  print(response?.statusMessage);
                },
                child: const Text('Netio Get')),
            TextButton(
                onPressed: () async {
                  final response = await Netio().post(
                      'https://jsonplaceholder.typicode.com/posts',
                      body: {
                        'title': 'foo',
                        'body': 'bar',
                        'userId': 1,
                      },
                      options: Options(headers: {
                        'Content-type': 'application/json; charset=UTF-8'
                      }));
                  print(response?.body);
                  print(response?.options?.contentLength);
                  print(response?.options?.method);
                  print(response?.errorMessage);
                  print(response?.statusCode);
                  print(response?.statusMessage);
                },
                child: const Text('Netio Post')),
          ],
        ),
      ),
    );
  }
}
