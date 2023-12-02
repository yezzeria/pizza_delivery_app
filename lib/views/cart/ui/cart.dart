import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_delivery_app/views/cart/bloc/cart_bloc.dart';
import 'package:pizza_delivery_app/views/cart/ui/cart_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 93,
          height: 52,
          child: Image.network(
              'https://img.artlebedev.ru/news/2019/party/suppliers/papa-johns/logo.png'),
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {},
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return Scaffold(
                body: ListView.builder(
                    itemCount: successState.cartItems.length,
                    itemBuilder: (context, index) {
                      return CartTileWidget(
                          cartBloc: cartBloc,
                          pizzaDataModel: successState.cartItems[index]);
                    }),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
