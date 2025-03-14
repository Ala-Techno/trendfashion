import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
}

// general failures

class NotFoundFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NotAvailableFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class BlockedUserFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ValidationFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ConnectionFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NotFounFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class BarcodeNotFoundFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class AiFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnauthenticatedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UserExistsFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ExpireFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnauthenticatedExceptionUserNameOrPasswordFailure extends Failure {
  final String message;
  UnauthenticatedExceptionUserNameOrPasswordFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class UnauthenticatedExceptionEmailOrUserNameFailure extends Failure {
  final String message;
  UnauthenticatedExceptionEmailOrUserNameFailure(this.message);

  @override
  List<Object?> get props => [message];
}

String mapFailureToMessage(Failure failure) {
  if (failure is UnauthenticatedExceptionUserNameOrPasswordFailure) {
    return failure.message;
  }
  if (failure is UnauthenticatedExceptionEmailOrUserNameFailure) {
    return failure.message;
  } else if (failure is ServerFailure) {
    return 'عذراً لم نتمكن من الاتصال بالخادم';
  } else if (failure is NotFoundFailure) {
    return 'لاتوجد أي بيانات في الوقت الحالي!';
  } else if (failure is UnauthenticatedFailure) {
    return 'اسم المستخدم أو كلمة المرور غير صحيحة'; // Better message
  } else if (failure is BlockedUserFailure) {
    return 'عذرا ! لقد تم حظر حسابك. يرجى التواصل مع المسؤول لإزالة الحظر';
  } else if (failure is NotAvailableFailure) {
    return 'هذا الطلب غير متاح ';
  } else if (failure is ValidationFailure) {
    return 'البيانات التي ادخلتها غير صحيحه ';
  } else if (failure is ConnectionFailure) {
    return 'لا يوجد اتصال بالانترنت ';
  } else if (failure is CacheFailure) {
    return 'لا يوجد بيانات بالتخزين المؤقت ';
  } else if (failure is BarcodeNotFoundFailure) {
    return 'الباركود غير موجودة ';
  } else if (failure is AiFailure) {
    return 'لم يتم التعرف على المنتج';
  } else {
    return 'عذراً حدث خطأ غير متوقع';
  }
}
