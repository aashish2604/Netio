import 'dart:convert';
import 'dart:io';

import 'package:netio/src/options.dart';
import 'package:netio/src/response.dart';

class Netio {
  void initClient(HttpClient client, Options? options) {
    client.connectionTimeout = options?.connectTimeout;
    if (options != null) {
      if (options.idleTimeout != null) {
        client.idleTimeout = options.idleTimeout!;
      }
    }
  }

  HttpClientRequest initRequest(HttpClientRequest request, Options? options) {
    options?.headers?.forEach((key, value) {
      request.headers.add(key, value);
    });

    if (options != null) {
      request.persistentConnection = options.persistentConnection;
      request.followRedirects = options.followRedirects;
      if (request.followRedirects == true) {
        request.maxRedirects = options.maxRedirects;
      }
      request.bufferOutput = options.bufferOutput;
      if (options.contentLength != null) {
        request.contentLength = options.contentLength!;
      }
    }

    return request;
  }

  /// Function used for making HTTP GET request
  Future<Response?> get(String path, {Options? options}) async {
    Uri url = Uri.parse(path);
    final client = HttpClient();
    try {
      Map<String, String>? stringQueryParameters = {};
      options?.queryParameters?.forEach((key, value) {
        stringQueryParameters.addAll({key: value.toString()});
      });
      url.replace(
        queryParameters: stringQueryParameters,
      );
      //initializing the client
      initClient(client, options);
      //starting a request
      final uninitializedrequest = await client.getUrl(url);
      final request = initRequest(uninitializedrequest, options);
      options?.method = request.method;
      //closing the request
      final response = await request.close();

      //processing the response
      final responseBody = await response.transform(utf8.decoder).join();
      final parsedResponse =
          Response.fromHttpResponse(response, responseBody, options);
      return parsedResponse;
    } catch (e) {
      if (e is HttpException) {
        return Response(isSuccessfull: false, errorMessage: e.message);
      } else {
        return null;
      }
    } finally {
      client.close();
    }
  }

  /// Function used for making HTTP POST request
  Future<Response?> post(String path,
      {Options? options, Map<String, dynamic>? body}) async {
    Uri url = Uri.parse(path);
    final httpClient = HttpClient();
    try {
      Map<String, String>? stringQueryParameters = {};
      options?.queryParameters?.forEach((key, value) {
        stringQueryParameters.addAll({key: value.toString()});
      });
      url.replace(
        queryParameters: stringQueryParameters,
      );
      initClient(httpClient, options);
      final encodedBody = jsonEncode(body);

      final uninitializedRequest = await httpClient.postUrl(url);
      final request = initRequest(uninitializedRequest, options);
      options?.method = request.method;

      request.write(encodedBody);

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      Response parsedResponse =
          Response.fromHttpResponse(response, responseBody, options);
      return parsedResponse;
    } catch (e) {
      if (e is HttpException) {
        return Response(isSuccessfull: false, errorMessage: e.message);
      } else {
        return null;
      }
    } finally {
      httpClient.close();
    }
  }
}

//TODO: Identifying different types of errors and handling them appropriately
