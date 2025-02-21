part of 'Home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class CategoriesInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class CategoriesLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class CategoriesILoaded extends HomeState {
  List<CategoriesModel> categoriesModel;
  CategoriesILoaded({required this.categoriesModel});

  @override
  List<Object> get props => [CategoriesModel];
}

class CategoriesError extends HomeState {
  String errorMessage;

  CategoriesError({required this.errorMessage});

  @override
  List<Object> get props => [];
}

//////
///
class FeaturedProductInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class FeaturedProductLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class FeaturedProductILoaded extends HomeState {
  List<ProductModel> productModel;
  FeaturedProductILoaded({required this.productModel});

  @override
  List<Object> get props => [productModel];
}

class FeaturedProductError extends HomeState {
  String errorMessage;

  FeaturedProductError({required this.errorMessage});

  @override
  List<Object> get props => [];
}

//////
///
class carouselInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class carouselLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class carouselLoaded extends HomeState {
  List<CarouselModel> carouselModel;
  carouselLoaded({required this.carouselModel});

  @override
  List<Object> get props => [carouselModel];
}

class carouselError extends HomeState {
  String errorMessage;

  carouselError({required this.errorMessage});

  @override
  List<Object> get props => [];
}
