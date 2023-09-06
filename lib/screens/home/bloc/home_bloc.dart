import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:learning_bloc/data/cart_items.dart';
import 'package:learning_bloc/data/products.dart';
import 'package:learning_bloc/data/wishlist_items.dart';
import 'package:learning_bloc/screens/home/models/product.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeStartedEvent>(homeStartedEvent);
    on<WishListEvent>(wishListEvent);
    on<ShoppingCartEvent>(shoppingCartEvent);
    on<AddToWishListEvent>(addToWishListEvent);
    on<AddToCartEvent>(addToCartEvent);
  }

  FutureOr<void> homeStartedEvent(
    HomeStartedEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(
      HomeSuccessState(
        products: GroceryProducts.products
            .map(
              (e) => Product(
                id: e['id'],
                name: e['name'],
                desc: e['desc'],
                price: e['price'],
                imageURL: e['imageURL'],
              ),
            )
            .toList(),
      ),
    );
  }

  FutureOr<void> wishListEvent(
    WishListEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeToWishListNavigationActionState());
  }

  FutureOr<void> shoppingCartEvent(
    ShoppingCartEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeToShoppingCartNavigationActionState());
  }

  FutureOr<void> addToWishListEvent(
    AddToWishListEvent event,
    Emitter<HomeState> emit,
  ) {
    wishListItems.add(event.product);
    emit(HomeProductAddedToWishListState());
  }

  FutureOr<void> addToCartEvent(
    AddToCartEvent event,
    Emitter<HomeState> emit,
  ) {
    cartItems.add(event.product);
    emit(HomeProductAddedToCartState());
  }
}
