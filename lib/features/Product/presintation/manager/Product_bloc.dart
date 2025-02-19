import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendfashion/dataProviders/error/failures.dart';
import '../../data/repository/ProductRepository.dart';
import 'package:trendfashion/features/Product/data/model/ProductModel.dart';

part 'Product_event.dart';
part 'Product_state.dart';

class Product_bloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  Product_bloc({required this.repository}) : super(ProductInitial()) {
    on<GetAllProduct>(_handleGetAllProducts);
  }

  FutureOr<void> _handleGetAllProducts(
      GetAllProduct event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading());
      final failureOrData = await repository.getAllProduct();

      failureOrData.fold(
        (failure) {
          log('Product load error: ${mapFailureToMessage(failure)}');
          emit(ProductError(errorMessage: mapFailureToMessage(failure)));
        },
        (data) {
          log('Product loaded successfully');
          emit(ProductILoaded(productModel: data));
        },
      );
    } catch (e) {
      log('Unexpected error: $e');
      emit(ProductError(errorMessage: 'An unexpected error occurred'));
    }
  }
}
