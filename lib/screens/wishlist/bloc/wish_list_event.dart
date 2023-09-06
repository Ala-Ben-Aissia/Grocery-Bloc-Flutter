part of 'wish_list_bloc.dart';

@immutable
abstract class WishListEvent {}

class WishListStartedEvent extends WishListEvent {
}

class WishListRemoveProductEvent extends WishListEvent {
  final Product product;

  WishListRemoveProductEvent({required this.product});
}
