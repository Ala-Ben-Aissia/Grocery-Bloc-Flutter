part of 'wish_list_bloc.dart';

@immutable
abstract class WishListState {}

@immutable
abstract class WishListActionState extends WishListState {}

final class WishListInitial extends WishListState {}

class WishListSuccessState extends WishListState {
  final List<Product> products;

  WishListSuccessState({required this.products});
}

class WishListErrorState extends WishListState {}

class WishListProductRemovedState extends WishListActionState {}
