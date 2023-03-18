<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# **Netio**

A powerful HTTTP client which allows users to make API calls with greater efficiency.

## Features

The current version supports client requests with GET, POST, PUT, DELETE methods. The project is pretty young and under development, so a ton of new features will be added soon.

<!-- ## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package. -->

## Usage

Create a Netio instance.

```dart
final netio = Netio();
```
Simple GET request

```dart
Response? response = await netio.get(
    'https://jsonplaceholder.typicode.com/posts');

print(response?.body);
```

Advanced GET request with query parameters, a specifc maximum number of redirects along with the allowed idle timeout.

```dart
Response? response = await netio.get(
    'https://jsonplaceholder.typicode.com/posts',
    options: Options(
        queryParameters: {'userId': 1},
        maxRedirects: 2,
        idleTimeout: const Duration(seconds: 10)));

print(response?.body);
```

Similarly a POST request with upload data speicfied in "body" will be made as follows

```dart
Response? response = await Netio().post(
    'https://jsonplaceholder.typicode.com/posts',
    body: {
    'title': 'foo',
    'body': 'bar',
    'userId': 1,
    },
    options: Options(headers: {
    'Content-type': 'application/json; charset=UTF-8'
    }));
```

Making a PUT request

```dart
Response? reponse = await netio.put(
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
```

DELETE request

```dart
Response? response = await netio.delete(
    'https://jsonplaceholder.typicode.com/posts/1',
    );
```

## Request Options

The **Options** class describes the http request information and configuration. This specifies the additional information like the query parameters, headers, etc that are needed to be passed in the request. The **Options** declaration is as follows:

```dart
//This specifies the method used for making the request
  String? method;

  /// The function will wait atmost this amount of time while establishing
  /// connection to the server before throwing connection timeout
  Duration? connectTimeout;

  /// Use this to specify the maximum amount of time elaspsed while processing the call.
  /// After this time is over the call will be terminated automatically
  Duration? idleTimeout;

  /// The query parameters required while making the API call
  Map<String, dynamic>? queryParameters;

  /// The header which would be sent via the API call to the server in the request
  Map<String, dynamic>? headers;

  /// Set this property to false if this request should not automatically follow redirects. The default is true.
  bool followRedirects;

  /// Set this property to the maximum number of redirects to follow when [followRedirects] is true.
  /// If this number is exceeded an error will be thrown
  int maxRedirects;

  /// Request persistant connection state. Default value: true
  bool persistentConnection;

  /// Default value is true.
  /// Disabling buffering of the output can result in very poor performance,
  /// when writing many small chunks.
  bool bufferOutput;

  /// Specifies the content length of the request
  int? contentLength;
```

## Response

The response for a request is returned as a class **Response** which contains the following information.
```dart
  /// The Response body recieved from the API call
  String? body;

  /// The request options
  Options? options;

  /// Status code returned in response to the API request
  int? statusCode;

  /// Message recieved alongwith the status code in response to the API request
  String? statusMessage;

  /// Shows whether the API call was made.
  /// NOTE: This only indicated whether the call for the request was made or not.
  ///  This doesn't indicate that a status code of 2XX was recieved.
  ///  It will be true for all the status codes.
  bool isSuccessfull;

  /// Error message recieved if [isSuccessfull is false]
  String? errorMessage;
```

For the complete code refer to the example file of this project.

## Issues

Please file any issues, bugs or feature request as an issue on the GitHub page. If you have some idea for future upgrade, feel free to contact us.
