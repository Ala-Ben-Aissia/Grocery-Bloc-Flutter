part of 'home_bloc.dart';

abstract class HomeState {} // build ui

abstract class HomeActionState extends HomeState {} // listen to actions

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<Product> products;
  HomeSuccessState({required this.products});
}

class HomeErrorState extends HomeState {}

class HomeToWishListNavigationActionState extends HomeActionState {}

class HomeToShoppingCartNavigationActionState extends HomeActionState {}

class HomeProductAddedToWishListState extends HomeActionState {}

class HomeProductAddedToCartState extends HomeActionState {


  HomeProductAddedToCartState();
}
