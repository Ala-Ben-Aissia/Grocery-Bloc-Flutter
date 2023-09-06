import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/data/cart_items.dart';
import 'package:learning_bloc/data/wishlist_items.dart';
import 'package:learning_bloc/screens/cart/bloc/cart_bloc.dart';
import 'package:learning_bloc/screens/cart/ui/cart.dart';
import 'package:learning_bloc/screens/home/bloc/home_bloc.dart';
import 'package:learning_bloc/screens/home/ui/widgets/home_product_widget.dart';
import 'package:learning_bloc/screens/wishlist/ui/wish_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    homeBloc.add(HomeStartedEvent());
    super.initState();
  }

  final CartBloc cartBloc = CartBloc();
  int cartItemsLength = 0;
  int wishListLength = 0;

  _getCartItemsLength() async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => Cart()));
    setState(() {
      cartItemsLength = result ?? 0;
    });
  }

  _getWishListLength() async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => WishList()));
    setState(() {
      wishListLength = result ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) {
        return current is HomeActionState;
      },
      buildWhen: (previous, current) {
        return current is! HomeActionState; // current is HomeState
      },
      listener: (context, state) {
        if (state is HomeToWishListNavigationActionState) {
          _getWishListLength();
        } else if (state is HomeToShoppingCartNavigationActionState) {
          _getCartItemsLength();
        } else if (state is HomeProductAddedToWishListState) {
          setState(() {
            wishListLength = wishListItems.length;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 500),
              backgroundColor: Colors.teal,
              content: Text('Item added to your Favourites'),
            ),
          );
        } else if (state is HomeProductAddedToCartState) {
          setState(() {
            cartItemsLength = cartItems.length;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 500),
              backgroundColor: Colors.teal,
              content: Text('Item added to your Cart'),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is HomeSuccessState) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'Grocery',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.teal,
              actions: [
                Column(
                  children: [
                    Flexible(
                      child: IconButton(
                        onPressed: () {
                          homeBloc.add(WishListEvent());
                        },
                        icon: const Icon(
                          Icons.favorite_border_outlined,
                          size: 35,
                        ),
                      ),
                    ),
                    Flexible(child: Text('$wishListLength'.padLeft(10))),
                  ],
                ),
                Column(
                  children: [
                    Flexible(
                      child: IconButton(
                        onPressed: () {
                          homeBloc.add(ShoppingCartEvent());
                        },
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 35,
                        ),
                      ),
                    ),
                    Flexible(child: Text('$cartItemsLength'.padLeft(10))),
                  ],
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductTile(
                  homeBloc: homeBloc,
                  product: state.products[index],
                );
              },
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Error occured'),
            ),
          );
        }
      },
    );
  }
}
