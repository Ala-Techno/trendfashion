// import 'dart:async';
// import 'dart:developer';
// import 'package:bloc/bloc.dart';
// import 'package:trendfashion/dataProviders/error/failures.dart';
// import 'package:trendfashion/features/Favorite/data/repository/Favoriterepository.dart';
// import 'package:trendfashion/features/Favorite/presintation/manager/Favorite_event.dart';
// import 'package:trendfashion/features/Favorite/presintation/manager/Favorite_state.dart';

// class Favorite_bloc extends Bloc<FavoriteEvent, FavoriteState> {
//   final Favoriterepository repository;

//   Favorite_bloc({required this.repository}) : super(FavoriteInitial()) {
//     on<LoadFavorites>(_handleLoadFavorites);
//     on<ToggleFavoriteEvent>(_handleToggleFavorite);
//   }

//   Future<void> _handleLoadFavorites(
//     LoadFavorites event,
//     Emitter<FavoriteState> emit,
//   ) async {
//     try {
//       emit(FavoriteLoading());
//       final result = await repository.getAllFavorites();
//       emit(FavoriteLoaded(Favorite: result));
//     } catch (e) {
//       emit(FavoriteError(errorMessage: e.toString()));
//     }
//   }

//   Future<void> _handleToggleFavorite(
//     ToggleFavoriteEvent event,
//     Emitter<FavoriteState> emit,
//   ) async {
//     try {
//       final currentState = state;
//       if (currentState is FavoriteLoaded) {
//         await repository.toggleFavorite(event.product);
//         final updated = await repository.getAllFavorites();
//         emit(FavoriteLoaded(Favorite: updated));
//       }
//     } catch (e) {
//       emit(FavoriteError(errorMessage: e.toString()));
//     }
//   }
// }
