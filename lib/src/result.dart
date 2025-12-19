// lib/src/result.dart

/// Represents the result of a business operation.
///
/// A [Result] is either a [Success] containing data,
/// or a [Failure] containing an error message.
sealed class Result<T> {
  const Result();
}

/// Represents a successful result containing [data].
class Success<T> extends Result<T> {
  /// The successful result data.
  final T data;

  /// Creates a success result.
  const Success(this.data);
}

/// Represents a failed result containing an error [message].
class Failure<T> extends Result<T> {
  /// Human-readable error message.
  final String message;

  /// Optional underlying error.
  final Object? error;

  /// Optional stack trace.
  final StackTrace? stackTrace;

  /// Creates a failure result.
  const Failure(this.message, [this.error, this.stackTrace]);
}
