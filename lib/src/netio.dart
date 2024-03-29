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

  /// Use this function for making HTTP GET request
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
      final parsedResponse = Response.fromHttpResponse(
          response, responseBody, options, request.method);
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

  /// Use this function for making HTTP POST request
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

      Response parsedResponse = Response.fromHttpResponse(
          response, responseBody, options, request.method);
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

  ///Use this function for making HTTP PUT request
  Future<Response?> put(String path,
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

      final uninitializedRequest = await httpClient.putUrl(url);
      final request = initRequest(uninitializedRequest, options);
      options?.method = request.method;

      request.write(encodedBody);

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      Response parsedResponse = Response.fromHttpResponse(
          response, responseBody, options, request.method);
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

  ///Use this function for making HTTP DELETE request
  Future<Response?> delete(String path, {Options? options}) async {
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
      final uninitializedrequest = await client.deleteUrl(url);
      final request = initRequest(uninitializedrequest, options);
      options?.method = request.method;
      //closing the request
      final response = await request.close();

      //processing the response
      final responseBody = await response.transform(utf8.decoder).join();
      final parsedResponse = Response.fromHttpResponse(
          response, responseBody, options, request.method);
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

  ///Use this function for making HTTP PATCH request
  Future<Response?> patch(String path,
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

      final uninitializedRequest = await httpClient.patchUrl(url);
      final request = initRequest(uninitializedRequest, options);
      options?.method = request.method;

      request.add(utf8.encode(encodedBody));
      final response = await request.close();
      final responseBody = await utf8.decodeStream(response);

      final parsedResponse = Response.fromHttpResponse(
          response, responseBody, options, request.method);
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

  ///Use this function to make HTTP HEAD request
  Future<Response?> head(String path, {Options? options}) async {
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
      final uninitializedrequest = await client.headUrl(url);
      final request = initRequest(uninitializedrequest, options);
      options?.method = request.method;
      //closing the request
      final response = await request.close();

      //processing the response
      final responseBody = await response.transform(utf8.decoder).join();
      print(responseBody);
      final parsedResponse =
          Response.fromHttpResponse(response, null, options, request.method);
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

  /// Use this function for making HTTP CONNECT request
  Future<Response?> connect(String path, {Options? options}) async {
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
      final uninitializedrequest = await client.openUrl("CONNECT", url);
      final request = initRequest(uninitializedrequest, options);
      options?.method = request.method;
      //closing the request
      final response = await request.close();

      //processing the response
      final responseBody = await response.transform(utf8.decoder).join();
      final parsedResponse = Response.fromHttpResponse(
          response, responseBody, options, request.method);
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
}
