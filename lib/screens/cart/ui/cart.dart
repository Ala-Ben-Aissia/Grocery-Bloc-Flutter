import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/data/cart_items.dart';
import 'package:learning_bloc/screens/cart/bloc/cart_bloc.dart';
import 'package:learning_bloc/screens/cart/ui/widgets/cart_product_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartStartedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: ()=>Navigator.pop(context, cartItems.length),
          icon:Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          if (state is CartItemRemovedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                backgroundColor: Colors.teal,
                content: Text('Item has been removed from your cart'),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case CartSuccessState:
              state as CartSuccessState;
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) => CartProduct(
                  cartBloc: cartBloc,
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
