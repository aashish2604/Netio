import 'dart:convert';
import 'dart:io';

import 'package:netio/src/options.dart';
import 'package:netio/src/response.dart';

class Netio {
  /// Method used for making HTTP GET request
  Future<Response?> get(String path, {Options? options}) async {
    Uri url = Uri.parse(path);
    try {
      url.replace(
        queryParameters: options?.queryParameters,
      );
      final client = HttpClient();
      final request = await client.getUrl(url);

      options?.headers?.forEach((key, value) {
        request.headers.add(key, value);
      });

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      final parsedResponse = Response.fromHttpResponse(response, responseBody);
      return parsedResponse;
    } catch (e) {
      return null;
    }
  }

  /// Method used for making HTTP POST request
  Future<Response?> post(String path,
      {Options? options, Map<String, dynamic>? body}) async {
    Uri url = Uri.parse(path);
    final httpClient = HttpClient();
    try {
      url.replace(
        queryParameters: options?.queryParameters,
      );
      final encodedBody = jsonEncode(body);

      final request = await httpClient.postUrl(url);
      options?.headers?.forEach((key, value) {
        request.headers.add(key, value);
      });
      request.write(encodedBody);

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      Response parsedResponse =
          Response.fromHttpResponse(response, responseBody);
      return parsedResponse;
    } catch (e) {
      return null;
    } finally {
      httpClient.close();
    }
  }
}


//TODO: Add all the option for the function call
