import 'dart:io';

typedef ProgressCallback = void Function(int count, int total);

enum ListFormat {
  /// Comma-separated values
  /// e.g. (foo,bar,baz)
  csv,

  /// Space-separated values
  /// e.g. (foo bar baz)
  ssv,

  /// Tab-separated values
  /// e.g. (foo\tbar\tbaz)
  tsv,

  /// Pipe-separated values
  /// e.g. (foo|bar|baz)
  pipes,

  /// Multiple parameter instances rather than multiple values.
  /// e.g. (foo=value&foo=another_value)
  multi,

  /// Forward compatibility
  /// e.g. (foo[]=value&foo[]=another_value)
  multiCompatible,
}

typedef ValidateStatus = bool Function(int? status);

enum ResponseType {
  /// Transform the response data to JSON object only when the
  /// content-type of response is "application/json" .
  json,

  /// Get the response stream without any transformation. The
  /// Response data will be a `ResponseBody` instance.
  stream,

  /// Transform the response data to a String encoded with UTF8.
  plain,

  /// Get original bytes, the type of [Response.data] will be List<int>
  bytes
}

class Options {
  String? method;
  Duration? connectTimeout;
  Duration? idleTimeout;
  Map<String, dynamic>? queryParameters;
  Map<String, dynamic>? headers;
  ResponseType? responseType;
  ValidateStatus? validateStatus;
  bool? receiveDataWhenStatusError;
  bool followRedirects;
  int? maxRedirects;
  bool persistentConnection;
  ListFormat? listFormat;

  Options({
    this.method,
    this.connectTimeout,
    this.idleTimeout,
    this.queryParameters,
    this.headers,
    this.responseType = ResponseType.json,
    this.validateStatus,
    this.receiveDataWhenStatusError,
    this.followRedirects = true,
    this.maxRedirects,
    this.persistentConnection = true,
    this.listFormat,
  });

  Options fromHttpResponse(HttpClientResponse resposne) {
    return Options();
  }
}
