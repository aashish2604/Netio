import 'dart:convert';
import 'dart:io';

class Netio {
  Future<String> get(String path) async {
    Uri url = Uri.parse(path);
    try {
      final client = HttpClient();
      final request = await client.getUrl(url);
      final response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();
        print(responseBody);
        return responseBody;
      } else {
        print('Error: ${response.statusCode}');
        return 'error';
      }
    } catch (e) {
      print('Error: $e');
      return 'Error';
    }
  }

  Future<String> post(String path) async {
    final httpClient = HttpClient();
    Uri url = Uri.parse(path);

    try {
      final body = jsonEncode({
        'title': 'foo',
        'body': 'bar',
        'userId': 1,
      });

      final request = await httpClient.postUrl(url);
      request.headers.add(
          HttpHeaders.contentTypeHeader, 'application/json; charset=UTF-8');
      request.write(body);

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      print('Response status code: ${response.statusCode}');
      print('Response body: $responseBody');
      return 'Success';
    } catch (e) {
      print('Error occurred: $e');
      return 'error';
    } finally {
      httpClient.close();
    }
  }
}
