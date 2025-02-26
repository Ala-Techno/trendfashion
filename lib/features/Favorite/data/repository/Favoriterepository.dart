import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:trendfashion/dataProviders/error/failures.dart';
import 'package:trendfashion/dataProviders/local_data_provider.dart';
import 'package:trendfashion/dataProviders/network/Network_info.dart';
import 'package:trendfashion/dataProviders/remote_data_provider.dart';
import 'package:trendfashion/dataProviders/repository.dart';
import 'package:trendfashion/features/Favorite/presintation/manager/Favorite_event.dart';
import 'package:trendfashion/features/Product/data/model/ProductModel.dart';
import '../../../../dataProviders/local_data_provider_hive.dart';
import '../../../../dataProviders/network/data_source_url.dart';

class Favoriterepository extends Repository {
  final Local_data_provider_hive
      local_data_provider_hive; //get the data from the local cache

  final Box<ProductModel> _favoriteBox;
  Favoriterepository(
    this._favoriteBox, {
    required this.local_data_provider_hive,
    // required this.networkInfo,
  });

  Future<List<ProductModel>> getAllFavorites() async {
    return _favoriteBox.values.toList();
  }

  Future<void> toggleFavorite(ProductModel product) async {
    if (_favoriteBox.containsKey(product.id)) {
      await _favoriteBox.delete(product.id);
    } else {
      await _favoriteBox.put(product.id, product);
    }
  }
}
