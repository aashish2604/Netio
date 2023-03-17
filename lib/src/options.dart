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
  Options(
      {this.method,
      this.connectTimeout,
      this.idleTimeout,
      this.queryParameters,
      this.headers,
      // this.responseType = ResponseType.json,
      // this.validateStatus,
      // this.receiveDataWhenStatusError,
      this.followRedirects = true,
      this.maxRedirects = 5,
      this.persistentConnection = true,
      this.bufferOutput = true,
      this.contentLength
      // this.listFormat,
      });

  Options copyWith(
          {String? method,
          Duration? connectTimeout,
          Duration? idleTimeout,
          Map<String, dynamic>? queryParameters,
          Map<String, dynamic>? headers,
          bool? followRedirects,
          int? maxRedirects,
          bool? persistentConnection,
          bool? bufferOutput,
          int? contentLength}) =>
      Options(
          method: method ?? this.method,
          connectTimeout: connectTimeout ?? this.connectTimeout,
          idleTimeout: idleTimeout ?? this.idleTimeout,
          queryParameters: queryParameters ?? this.queryParameters,
          headers: headers ?? this.headers,
          followRedirects: followRedirects ?? this.followRedirects,
          maxRedirects: maxRedirects ?? this.maxRedirects,
          persistentConnection:
              persistentConnection ?? this.persistentConnection,
          bufferOutput: bufferOutput ?? this.bufferOutput,
          contentLength: contentLength ?? this.contentLength);

  ///This specifies the method used for making the request
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
  // ResponseType? responseType;
  // ValidateStatus? validateStatus;
  // bool? receiveDataWhenStatusError;
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
  // ListFormat? listFormat;
}
