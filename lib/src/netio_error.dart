import 'package:netio/netio.dart';

enum NetioErrorType {
  /// Caused by a connection timeout.
  connectionTimeout,

  /// It occurs when url is sent timeout.
  sendTimeout,

  ///It occurs when receiving timeout.
  receiveTimeout,

  /// Caused by an incorrect certificate as configured by [ValidateCertificate].
  badCertificate,

  /// This is caused by an incorrect status code as configured by
  /// [ValidateStatus].
  badResponse,

  /// When the request is cancelled, netio will throw a error with this type.
  cancel,

  /// Caused for example by a `xhr.onError` or SocketExceptions.
  connectionError,

  /// This error is thrown when the error type is not known
  unknown,
}

/// The object containing the error info for failed requests
class NetioError implements Exception {
  const NetioError({
    required this.requestOptions,
    this.response,
    this.errorType = NetioErrorType.unknown,
    this.error,
    StackTrace? stackTrace,
    this.message,
  }) : stackTrace = identical(stackTrace, StackTrace.empty) ? null : stackTrace;

  const NetioError.badResponse({
    required int statusCode,
    required this.requestOptions,
    required this.response,
  })  : errorType = NetioErrorType.badResponse,
        message = "",
        error = null,
        stackTrace = null;

  const NetioError.connectionTimeout({
    required Duration timeout,
    required this.requestOptions,
    this.error,
    StackTrace? stackTrace,
  })  : errorType = NetioErrorType.connectionTimeout,
        message = 'The request connection took '
            'longer than $timeout. It was aborted.',
        response = null,
        stackTrace =
            identical(stackTrace, StackTrace.empty) ? null : stackTrace;

  const NetioError.sendTimeout({
    required Duration timeout,
    required this.requestOptions,
  })  : errorType = NetioErrorType.sendTimeout,
        message = 'The request took '
            'longer than $timeout to send data. It was aborted.',
        response = null,
        error = null,
        stackTrace = null;

  const NetioError.receiveTimeout({
    required Duration timeout,
    required this.requestOptions,
    StackTrace? stackTrace,
  })  : errorType = NetioErrorType.receiveTimeout,
        message = 'The request took '
            'longer than $timeout to receive data. It was aborted.',
        response = null,
        error = null,
        stackTrace =
            identical(stackTrace, StackTrace.empty) ? null : stackTrace;

  const NetioError.requestCancelled({
    required this.requestOptions,
    required Object? reason,
    StackTrace? stackTrace,
  })  : errorType = NetioErrorType.cancel,
        message = 'The request was cancelled.',
        error = reason,
        response = null,
        stackTrace =
            identical(stackTrace, StackTrace.empty) ? null : stackTrace;

  const NetioError.connectionError({
    required this.requestOptions,
    required String reason,
  })  : errorType = NetioErrorType.connectionError,
        message = 'The connection errored: $reason',
        response = null,
        error = null,
        stackTrace = null;

  /// The request options for the failed request
  final Options requestOptions;

  /// The response data for the failed request
  /// It may be `null`
  final Response? response;

  /// The error type which is thrown
  final NetioErrorType errorType;

  /// The original error/exception object;
  final Object? error;

  /// The stacktrace of the original error/exception object
  final StackTrace? stackTrace;

  /// The error message that was obtained on occurance of exception
  final String? message;

  NetioError copyWith({
    Options? requestOptions,
    Response? response,
    NetioErrorType? errorType,
    Object? object,
    StackTrace? stackTrace,
    String? message,
  }) {
    return NetioError(
        requestOptions: requestOptions ?? this.requestOptions,
        response: response ?? this.response,
        errorType: errorType ?? this.errorType,
        stackTrace: stackTrace ?? this.stackTrace,
        message: message ?? this.message);
  }
}
