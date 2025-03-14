import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'error/exceptions.dart';
import 'error/failures.dart';

typedef GetDataFunction = Future<dynamic> Function();
typedef GetCacheDataFunction = dynamic Function();

class Repository {
  Future<Either<Failure, dynamic>> sendRequest({
    GetDataFunction? remoteFunction,
    GetCacheDataFunction? getCacheDataFunction,
    Future<bool>? checkConnection,
  }) async {
    log('send request running');

    if (await checkConnection!) {
      log('check connection ');
      try {
        final remoteData = await remoteFunction!();
        log('the data is from repositories is $remoteData');
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthenticatedException {
        return Left(UnauthenticatedFailure());
      } on UnauthenticatedExceptionUserNameOrPassword catch (e) {
        return Left(
            UnauthenticatedExceptionUserNameOrPasswordFailure(e.message));
      } on UnauthenticatedExceptionEmailOrUserName catch (e) {
        return Left(UnauthenticatedExceptionEmailOrUserNameFailure(e.message));
      } on NotFound {
        return Left(NotFoundFailure());
      } on BlockedUser {
        return Left(BlockedUserFailure());
      } on BarcodeNotFoundException {
        return Left(BarcodeNotFoundFailure());
      } on ValidationException {
        return Left(ValidationFailure());
      } on CacheException {
        return Left(CacheFailure());
      } on AIException {
        return Left(AiFailure());
      }
    } else {
      if (getCacheDataFunction == null) {
        return Left(ConnectionFailure());
      }

      try {
        final localData = await getCacheDataFunction();
        return Right(localData);
      } on CacheException {
        return Left(CacheFailure());
      } on EmptyException {
        return Left(NotFoundFailure());
      } catch (Exception) {
        print(Exception);
        return Left(ConnectionFailure());
      }
    }
  }
}
