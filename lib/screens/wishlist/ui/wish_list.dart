import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/data/wishlist_items.dart';
import 'package:learning_bloc/screens/wishlist/bloc/wish_list_bloc.dart';
import 'package:learning_bloc/screens/wishlist/ui/widgets/wishlist_product.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final WishListBloc wishListBloc = WishListBloc();
  @override
  void initState() {
    wishListBloc.add(WishListStartedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fvourites'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: () => Navigator.pop(context, wishListItems.length),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: BlocConsumer<WishListBloc, WishListState>(
        bloc: wishListBloc,
        listenWhen: (previous, current) => current is WishListActionState,
        buildWhen: (previous, current) => current is! WishListActionState,
        listener: (context, state) {
          if (state is WishListProductRemovedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                backgroundColor: Colors.teal,
                content: Text('Item has been removed from your favourites'),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishListSuccessState:
              state as WishListSuccessState;
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) => WishListProduct(
                  wishListBloc: wishListBloc,
                  product: state.products[index],
                ),
              );

            default:
              return Container(
                child: Center(
                  child: Text('Error Occured'),
                ),
              );
          }
        },
      ),
    );
  }
}
