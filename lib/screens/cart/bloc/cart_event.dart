part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartStartedEvent extends CartEvent {}

class CartItemRemoveEvent extends CartEvent {
  final Product product;

  CartItemRemoveEvent({required this.product});
}
