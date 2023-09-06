import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:learning_bloc/data/wishlist_items.dart';
import 'package:learning_bloc/screens/home/models/product.dart';

part 'wish_list_event.dart';
part 'wish_list_state.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListInitial()) {
    on<WishListStartedEvent>(wishListStartedEvent);
    on<WishListRemoveProductEvent>(wishListRemoveProductEvent);
  }

  FutureOr<void> wishListStartedEvent(
    WishListStartedEvent event,
    Emitter<WishListState> emit,
  ) {
    emit(WishListSuccessState(products: wishListItems));
  }

  FutureOr<void> wishListRemoveProductEvent(
    WishListRemoveProductEvent event,
    Emitter<WishListState> emit,
  ) {
    wishListItems.remove(event.product);
    emit(WishListProductRemovedState());
    emit(WishListSuccessState(products: wishListItems));
  }
}
