class NotFound implements Exception {}

class ServerError implements Exception {}

class BlockedUserException implements Exception {}

class NotAvilable implements Exception {}

class ValidationException implements Exception {}

class InvalidCredentialsFailure implements Exception {}

class ServerException implements Exception {}

class BarcodeNotFoundException implements Exception {}

class BlockedUser implements Exception {}

class CacheException implements Exception {}

class EmptyException implements Exception {}

class InvalidException implements Exception {}

class NotFoundException implements Exception {}

class ExpireException implements Exception {}

class UniqueException implements Exception {}

class UserExistsException implements Exception {}

class ReceiveException implements Exception {}

class PasswordException implements Exception {}

class AIException implements Exception {}

class UnexpectedException implements Exception {}

class UnauthenticatedException implements Exception {
  // UnauthenticatedException(this.message);
}

class UnauthenticatedExceptionUserNameOrPassword implements Exception {
  final String message;

  UnauthenticatedExceptionUserNameOrPassword({required this.message});
}
class UnauthenticatedExceptionEmailOrUserName implements Exception {
  final String message;

  UnauthenticatedExceptionEmailOrUserName({required this.message});
}
class BlockedException implements Exception {}

class NoAvailableWorkHoursException implements Exception {}

class VerifyCodeException implements Exception {}
