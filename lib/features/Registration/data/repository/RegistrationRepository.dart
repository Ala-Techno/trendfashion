import 'package:dartz/dartz.dart';
import 'package:trendfashion/dataProviders/error/failures.dart';
import 'package:trendfashion/dataProviders/local_data_provider.dart';
import 'package:trendfashion/dataProviders/network/Network_info.dart';
import 'package:trendfashion/dataProviders/network/data_source_url.dart';
import 'package:trendfashion/dataProviders/remote_data_provider.dart';
import 'package:trendfashion/dataProviders/repository.dart';
import 'package:trendfashion/features/Registration/data/model/RegistrationModel.dart';

class RegistrationRepository extends Repository {
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final NetworkInfo networkInfo; //check if the device is connected to internet
  final LocalDataProvider localDataProvider;
  RegistrationRepository(
      {required this.remoteDataProvider,
      required this.networkInfo,
      required this.localDataProvider});

  Future<Either<Failure, dynamic>> singUp(
      String username, String email, String password) async {
    return await sendRequest(
      checkConnection: networkInfo.isConnected,
      remoteFunction: () async {
        RegistrationModel remoteData = await remoteDataProvider.sendJsonData(
          url: DataSourceURL.signup,
          returnType: RegistrationModel.init(),
          retrievedDataType: RegistrationModel.init(),
          jsonData: {
            'username': username,
            'email': email,
            'password': password,
          },
        );

        return remoteData;
      },
      // getCacheDataFunction: () async {}
    );
  }

  Future<Either<Failure, dynamic>> login(
      String username, String password) async {
    return await sendRequest(
      checkConnection: networkInfo.isConnected,
      remoteFunction: () async {
        RegistrationModel remoteData = await remoteDataProvider.sendJsonData(
          url: DataSourceURL.login,
          returnType: RegistrationModel.init(),
          retrievedDataType: RegistrationModel.init(),
          jsonData: {
            'username': username,
            'password': password,
          },
        );

        return remoteData;
      },
      //  getCacheDataFunction: () async {}
    );
  }
}



// Other Solution 

// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:trendfashion/dataProviders/error/exceptions.dart'
//     hide InvalidCredentialsFailure;

// import 'package:trendfashion/dataProviders/error/failures.dart';

// import 'package:trendfashion/dataProviders/local_data_provider.dart';
// import 'package:trendfashion/dataProviders/network/Network_info.dart';
// import 'package:trendfashion/dataProviders/network/data_source_url.dart';
// import 'package:trendfashion/dataProviders/remote_data_provider.dart';
// import 'package:trendfashion/dataProviders/repository.dart';
// import 'package:trendfashion/features/Registration/data/model/RegistrationModel.dart';

// class RegistrationRepository extends Repository {
//   final RemoteDataProvider remoteDataProvider; //get the data from the internet
//   final NetworkInfo networkInfo; //check if the device is connected to internet
//   final LocalDataProvider localDataProvider;
//   RegistrationRepository(
//       {required this.remoteDataProvider,
//       required this.networkInfo,
//       required this.localDataProvider});

//   Future<Either<Failure, dynamic>> singUp(
//       String username, String email, String password) async {
//     return await sendRequest(
//         checkConnection: networkInfo.isConnected,
//         remoteFunction: () async {
//           RegistrationModel remoteData = await remoteDataProvider.sendJsonData(
//             url: DataSourceURL.signup,
//             returnType: RegistrationModel.init(),
//             retrievedDataType: RegistrationModel.init(),
//             jsonData: {
//               'username': username,
//               'email': email,
//               'password': password,
//             },
//           );

//           return remoteData;
//         },
//         getCacheDataFunction: () async {});
//   }

//   Future<Either<Failure, dynamic>> login(
//       String username, String password) async {
//     return await sendRequest(
//       checkConnection: networkInfo.isConnected,
//       remoteFunction: () async {
//         try {
//           final response = await remoteDataProvider.sendJsonData(
//             url: DataSourceURL.login,
//             returnType: RegistrationModel.init(),
//             retrievedDataType: RegistrationModel.init(),
//             jsonData: {'username': username, 'password': password},
//           );
//           return response;
//         } on DioException catch (e) {
//           // Catch Dio errors first
//           if (e.response?.statusCode == 401) {
//             final message = e.response?.data['message'] ??
//                 'اسم المستخدم أو كلمة المرور غير صحيحة';
//             throw UnauthenticatedException(message);
//           }
//           throw ServerException();
//         } on UnauthenticatedException catch (e) {
//           // Catch our custom exception
//           return Left(InvalidCredentialsFailure(e.message));
//         } catch (e) {
//           return Left(ServerFailure());
//         }
//       },
//       getCacheDataFunction: () async => Left(CacheFailure()),
//     );
//   }
// }
