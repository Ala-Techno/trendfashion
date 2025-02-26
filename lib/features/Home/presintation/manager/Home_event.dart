part of 'Home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class CategoriesEvent extends HomeEvent {
  // const GetAllCategories();
  @override
  List<Object> get props => [];
}

class featuredProductEvent extends HomeEvent {
  // const GetAllCategories();
  @override
  List<Object> get props => [];
}

class CarouselEvent extends HomeEvent {
  // const GetAllCategories();
  @override
  List<Object> get props => [];
}
