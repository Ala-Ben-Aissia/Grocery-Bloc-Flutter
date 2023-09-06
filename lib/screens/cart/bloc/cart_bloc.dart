import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:learning_bloc/data/cart_items.dart';
import 'package:learning_bloc/screens/home/models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartStartedEvent>(cartStartedEvent);
    on<CartItemRemoveEvent>(cartItemRemoveEvent);
  }

  FutureOr<void> cartItemRemoveEvent(
    CartItemRemoveEvent event,
    Emitter<CartState> emit,
  ) {
    cartItems.remove(event.product);
    emit(CartItemRemovedState());
    emit(CartSuccessState(products: cartItems));
  }

  FutureOr<void> cartStartedEvent(
    CartStartedEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());
    await Future.delayed(Duration(milliseconds: 100));
    emit(CartSuccessState(products: cartItems));
  }
}
