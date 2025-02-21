import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendfashion/dataProviders/error/failures.dart';
import '../../data/repository/ProductDeatilsRepository.dart';
import 'package:trendfashion/features/ProductDeatils/data/model/ProductDeatilsModel.dart';

part 'ProductDeatils_event.dart';
part 'ProductDeatils_state.dart';

class ProductDeatils_bloc
    extends Bloc<ProductDeatilsEvent, ProductDeatilsState> {
  final ProductDeatilsRepository repository;

  ProductDeatils_bloc({required this.repository})
      : super(ProductDeatilsInitial());

  @override
  Stream<ProductDeatilsState> mapEventToState(
      ProductDeatilsEvent event) async* {
    if (event is GetAllProductDeatils) {
      yield ProductDeatilsLoading();
      final failureOrData = await repository.getAllProductDeatils(event.id);

      yield* failureOrData.fold(
        (failure) async* {
          log('yield is error');
          yield ProductDeatilsError(errorMessage: mapFailureToMessage(failure));
        },
        (data) async* {
          log('yield is loaded');
          yield ProductDeatilsILoaded(
            productDeatilsModel: data,
          );
        },
      );
    }
  }
}
