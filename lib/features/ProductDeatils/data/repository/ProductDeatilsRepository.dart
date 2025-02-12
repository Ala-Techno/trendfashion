import 'package:dartz/dartz.dart';
import 'package:trendfashion/dataProviders/error/failures.dart';
import 'package:trendfashion/dataProviders/local_data_provider.dart';
import 'package:trendfashion/dataProviders/network/Network_info.dart';
import 'package:trendfashion/dataProviders/network/data_source_url.dart';
import 'package:trendfashion/dataProviders/remote_data_provider.dart';
import 'package:trendfashion/dataProviders/repository.dart';
import 'package:trendfashion/features/ProductDeatils/data/model/ProductDeatilsModel.dart';

class ProductDeatilsRepository extends Repository {
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final NetworkInfo networkInfo; //check if the device is connected to internet
  final LocalDataProvider localDataProvider;
  ProductDeatilsRepository(
      {required this.remoteDataProvider,
      required this.networkInfo,
      required this.localDataProvider});

  Future<Either<Failure, dynamic>> getAllProductDeatils(String id) async {
    return await sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          ProductDeatilsModel remoteData = await remoteDataProvider.getData(
            url: DataSourceURL.getAllproducts + "/" + id,
            returnType: ProductDeatilsModel.init(),
            retrievedDataType: ProductDeatilsModel.init(),
          );

          return remoteData;
        },
        getCacheDataFunction: () async {});
  }
}
