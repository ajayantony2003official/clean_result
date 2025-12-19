// lib/src/api_executor.dart

import 'result.dart';
import 'business_exception.dart';

/// Executes an asynchronous operation safely and wraps the result
/// in a [Result] without throwing exceptions to the caller.
///
/// Intended to be used in data sources or repositories.
class ApiExecutor {
  /// Executes [apiCall] and returns a [Success] or [Failure].
  ///
  /// - [isTokenExpired] can be used to detect session expiration.
  /// - [unexpectedErrorMessage] is returned for unknown failures.
  /// - [sessionExpiredMessage] is returned when the token is expired.
  static Future<Result<T>> execute<T>({
    required Future<T> Function() apiCall,
    bool Function(T response)? isTokenExpired,
    String unexpectedErrorMessage = 'Unexpected error',
    String sessionExpiredMessage = 'Session expired',
  }) async {
    try {
      final response = await apiCall();

      if (isTokenExpired?.call(response) ?? false) {
        return Failure(sessionExpiredMessage);
      }

      return Success(response);
    } catch (e, stackTrace) {
      if (e is BusinessException) {
        return Failure(e.message);
      }

      return Failure(unexpectedErrorMessage, e, stackTrace);
    }
  }
}
