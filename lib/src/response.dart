import 'dart:convert';
import 'dart:io';

import 'package:netio/netio.dart';

class Response {
  String? body;
  Options? options;
  int? statusCode;
  String? statusMessage;

  Response({
    this.body,
    this.options,
    this.statusCode,
    this.statusMessage,
  });

  factory Response.fromHttpResponse(
      HttpClientResponse response, String? responseBody) {
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
    return Response(
        body: responseBody,
        options: Options(headers: responseHeader, baseUrl: ''),
        statusCode: response.statusCode,
        statusMessage: response.reasonPhrase);
  }
}

//TODO: Add a solid implementation for the options in the response
