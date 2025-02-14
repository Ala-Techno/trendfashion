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
      String username, String password, String email) async {
    return await sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          List<RegistrationModel> remoteData =
              await remoteDataProvider.sendJasonData(
            url: DataSourceURL.signup,
            returnType: RegistrationModel.init(),
            retrievedDataType: RegistrationModel.init(),
            body: {
              'username': username,
              'password': password,
              'email': email,
            },
          );

          return remoteData;
        },
        getCacheDataFunction: () async {});
  }
}
