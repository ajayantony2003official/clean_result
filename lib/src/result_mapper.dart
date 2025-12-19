// lib/src/result_mapper.dart

import 'result.dart';

/// Extension utilities for transforming and handling [Result] values.
extension ResultMapper<T> on Result<T> {
  /// Maps a successful result to another type.
  ///
  /// Failures are propagated unchanged.
  Result<R> map<R>(R Function(T data) transform) {
    if (this is Success<T>) {
      return Success(transform((this as Success<T>).data));
    }

    if (this is Failure<T>) {
      final failure = this as Failure<T>;
      return Failure(failure.message, failure.error, failure.stackTrace);
    }

    throw StateError('Unhandled Result type');
  }

  /// Maps a successful result asynchronously.
  ///
  /// Useful for repositories where additional async work
  /// (e.g. local storage) is required.
  Future<Result<R>> mapAsync<R>(Future<R> Function(T data) transform) async {
    if (this is Success<T>) {
      return Success(await transform((this as Success<T>).data));
    }

    if (this is Failure<T>) {
      final failure = this as Failure<T>;
      return Failure(failure.message, failure.error, failure.stackTrace);
    }

    throw StateError('Unhandled Result type');
  }

  /// Handles success and failure cases explicitly.
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(String message) onFailure,
  }) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).data);
    }

    if (this is Failure<T>) {
      return onFailure((this as Failure<T>).message);
    }

    throw StateError('Unhandled Result type');
  }
}
  