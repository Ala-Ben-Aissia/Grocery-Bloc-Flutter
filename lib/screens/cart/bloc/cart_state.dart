part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {

}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  final List<Product> products;

  CartSuccessState({required this.products});
}

class CartErrorState extends CartState {}

class CartItemRemovedState extends CartActionState {}
