import 'package:dartz/dartz.dart';
import 'package:trendfashion/dataProviders/error/failures.dart';
import 'package:trendfashion/dataProviders/local_data_provider.dart';
import 'package:trendfashion/dataProviders/network/Network_info.dart';
import 'package:trendfashion/dataProviders/network/data_source_url.dart';
import 'package:trendfashion/dataProviders/remote_data_provider.dart';
import 'package:trendfashion/dataProviders/repository.dart';
import 'package:trendfashion/features/Home/data/model/carouselModel.dart';
import 'package:trendfashion/features/Home/data/model/categoriesModel.dart';
import 'package:trendfashion/features/Home/presintation/manager/Home_bloc.dart';
import 'package:trendfashion/features/Product/data/model/ProductModel.dart';

class HomeRepository extends Repository {
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final NetworkInfo networkInfo; //check if the device is connected to internet
  final LocalDataProvider localDataProvider;
  HomeRepository(
      {required this.remoteDataProvider,
      required this.networkInfo,
      required this.localDataProvider});

  Future<Either<Failure, dynamic>> categories() async {
    return await sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          List<CategoriesModel> remoteData = await remoteDataProvider.getData(
            url: DataSourceURL.Categories,
            returnType: List,
            retrievedDataType: CategoriesModel.init(),
          );

          return remoteData;
        },
        getCacheDataFunction: () async {});
  }

  Future<Either<Failure, dynamic>> featured() async {
    return await sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          List<ProductModel> remoteData = await remoteDataProvider.getData(
            url: DataSourceURL.featuredProduct,
            returnType: List,
            retrievedDataType: ProductModel.init(),
          );

          return remoteData;
        },
        getCacheDataFunction: () async {});
  }

  Future<Either<Failure, dynamic>> carousel() async {
    return await sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          List<CarouselModel> remoteData = await remoteDataProvider.getData(
            url: DataSourceURL.carousel,
            returnType: List,
            retrievedDataType: CarouselModel.init(),
          );

          return remoteData;
        },
        getCacheDataFunction: () async {});
  }
}
