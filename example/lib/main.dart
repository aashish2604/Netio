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
    void logData(Response? response) {
      print(response?.body);
      print(response?.options?.contentLength);
      print(response?.options?.method);
      print(response?.errorMessage);
      print(response?.statusCode);
      print(response?.statusMessage);
    }

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
                          queryParameters: {'userId': 1},
                          maxRedirects: 2,
                          idleTimeout: const Duration(seconds: 10)));
                  logData(response);
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
                  logData(response);
                },
                child: const Text('Netio Post')),
            TextButton(
                onPressed: () async {
                  final response = await Netio().put(
                      'https://jsonplaceholder.typicode.com/posts/1',
                      body: {
                        'id': 1,
                        'title': 'foo',
                        'body': 'bar',
                        'userId': 1,
                      },
                      options: Options(headers: {
                        'Content-type': 'application/json; charset=UTF-8'
                      }));
                  logData(response);
                },
                child: const Text('Netio Put')),
            TextButton(
                onPressed: () async {
                  final response = await Netio().delete(
                    'https://jsonplaceholder.typicode.com/posts/1',
                  );
                  logData(response);
                },
                child: const Text('Netio Delete')),
            TextButton(
                onPressed: () async {
                  final response = await Netio().patch(
                      'https://jsonplaceholder.typicode.com/posts/1',
                      body: {
                        'title': 'foo',
                      },
                      options: Options(headers: {
                        'Content-type': 'application/json; charset=UTF-8'
                      }));
                  logData(response);
                },
                child: const Text('Netio Patch')),
            TextButton(
                onPressed: () async {
                  final response = await Netio()
                      .head('https://jsonplaceholder.typicode.com/posts');
                  logData(response);
                  print(response?.options?.headers);
                },
                child: const Text('Netio Head')),
            TextButton(
                onPressed: () async {
                  final response = await Netio()
                      .connect('https://jsonplaceholder.typicode.com/posts');
                  logData(response);
                  print(response?.options?.headers);
                },
                child: const Text('Netio Connect')),
          ],
        ),
      ),
    );
  }
}
