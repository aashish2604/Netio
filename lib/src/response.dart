import 'dart:io';

import 'package:netio/netio.dart';

class Response {
  /// The Response body recieved from the API call
  String? body;

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

  Response({
    this.body,
    this.options,
    this.statusCode,
    this.statusMessage,
    required this.isSuccessfull,
    this.errorMessage,
  });

  ///Generated a Response object from HttpClientResponse
  factory Response.fromHttpResponse(HttpClientResponse response,
      String? responseBody, Options? userOptions, String requestMethod) {
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
    ;
    late Options responseOptions;
    if (userOptions == null) {
      responseOptions = Options(
          method: requestMethod,
          headers: responseHeader,
          persistentConnection: response.persistentConnection,
          contentLength: response.contentLength);
    } else {
      responseOptions = userOptions.copyWith(
          method: requestMethod,
          headers: responseHeader,
          persistentConnection: response.persistentConnection,
          contentLength: response.contentLength);
    }
    return Response(
        isSuccessfull: true,
        body: responseBody,
        options: responseOptions,
        statusCode: response.statusCode,
        statusMessage: response.reasonPhrase);
  }
}
