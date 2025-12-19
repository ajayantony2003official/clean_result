// lib/src/business_exception.dart

/// Exception representing a business-level failure.
///
/// This should be thrown when an operation fails due to
/// business rules (e.g. invalid credentials),
/// not technical issues.
class BusinessException implements Exception {
  /// Error message describing the business failure.
  final String message;

  /// Creates a business exception with a message.
  const BusinessException(this.message);

  @override
  String toString() => message;
}
