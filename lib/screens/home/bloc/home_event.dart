part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeStartedEvent extends HomeEvent {}

class WishListEvent extends HomeEvent {}

class ShoppingCartEvent extends HomeEvent {}

class AddToWishListEvent extends HomeEvent {
  final Product product;

  AddToWishListEvent({required this.product});
}

class AddToCartEvent extends HomeEvent {
  final Product product;
  

  AddToCartEvent({required this.product});
}
