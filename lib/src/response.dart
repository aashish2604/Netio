import 'dart:convert';
import 'dart:io';

import 'package:netio/netio.dart';

class Response {
  String? body;
  Options? options;
  int? statusCode;
  String? statusMessage;
  bool isSuccessfull;
  String? errorMessage;

  Response({
    this.body,
    this.options,
    this.statusCode,
    this.statusMessage,
    required this.isSuccessfull,
    this.errorMessage,
  });

  factory Response.fromHttpResponse(
      HttpClientResponse response, String? responseBody, Options? userOptions) {
    HttpHeaders httpHeaders = response.headers;
    Map<String, dynamic>? responseHeader = {
      "transfer-encoding": httpHeaders.chunkedTransferEncoding,
      "content-length": httpHeaders.contentLength,
      "content-type": httpHeaders.contentType,
      "date": httpHeaders.date,
      "expires": httpHeaders.expires,
      "host": httpHeaders.host,
      "if-modified-since": httpHeaders.ifModifiedSince,
      "persistent-conntection": httpHeaders.persistentConnection,
      "port": httpHeaders.port
    };

    Options? repsonseOptions = userOptions?.copyWith(
        headers: responseHeader,
        persistentConnection: response.persistentConnection,
        contentLength: response.contentLength);
    return Response(
        isSuccessfull: true,
        body: responseBody,
        options: repsonseOptions,
        statusCode: response.statusCode,
        statusMessage: response.reasonPhrase);
  }
}
