import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendfashion/dataProviders/error/failures.dart';
import 'package:trendfashion/features/Home/data/model/carouselModel.dart';
import 'package:trendfashion/features/Home/data/model/categoriesModel.dart';
import 'package:trendfashion/features/Product/data/model/ProductModel.dart';
import '../../data/repository/HomeRepository.dart';

part 'Home_event.dart';
part 'Home_state.dart';

class Home_bloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  Home_bloc({required this.repository}) : super(HomeInitialState()) {
    on<CategoriesEvent>(_handlCategories);
    on<featuredProductEvent>(_handlefeaturedProduct);
    on<CarouselEvent>(_handlecarouselProduct);
  }

  FutureOr<void> _handlCategories(
      CategoriesEvent event, Emitter<HomeState> emit) async {
    try {
      emit(CategoriesLoading());
      final failureOrData = await repository.categories();

      failureOrData.fold(
        (failure) {
          log('Categories load error: ${mapFailureToMessage(failure)}');
          emit(CategoriesError(errorMessage: mapFailureToMessage(failure)));
        },
        (data) {
          log('Categories loaded successfully');
          emit(CategoriesILoaded(categoriesModel: data));
        },
      );
    } catch (e) {
      log('Unexpected error: $e');
      emit(CategoriesError(errorMessage: 'An unexpected error occurred'));
    }
  }

  FutureOr<void> _handlefeaturedProduct(
      featuredProductEvent event, Emitter<HomeState> emit) async {
    try {
      emit(FeaturedProductLoading());
      final failureOrData = await repository.featured();

      failureOrData.fold(
        (failure) {
          log('featured load error: ${mapFailureToMessage(failure)}');
          emit(
              FeaturedProductError(errorMessage: mapFailureToMessage(failure)));
        },
        (data) {
          log('featured loaded successfully');
          emit(FeaturedProductILoaded(productModel: data));
        },
      );
    } catch (e) {
      log('Unexpected error: $e');
      emit(FeaturedProductError(errorMessage: 'An unexpected error occurred'));
    }
  }

  FutureOr<void> _handlecarouselProduct(
      CarouselEvent event, Emitter<HomeState> emit) async {
    try {
      emit(carouselLoading());
      final failureOrData = await repository.carousel();

      failureOrData.fold(
        (failure) {
          log('carousel load error: ${mapFailureToMessage(failure)}');
          emit(carouselError(errorMessage: mapFailureToMessage(failure)));
        },
        (data) {
          log('carousel loaded successfully');
          emit(carouselLoaded(carouselModel: data));
        },
      );
    } catch (e) {
      log('Unexpected error: $e');
      emit(carouselError(errorMessage: 'An unexpected error occurred'));
    }
  }
}
