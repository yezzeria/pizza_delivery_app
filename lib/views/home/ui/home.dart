import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_delivery_app/views/cart/ui/cart.dart';
import 'package:pizza_delivery_app/views/home/bloc/home_bloc.dart';
import 'package:pizza_delivery_app/views/home/ui/pizza_tile_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
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
        actions: [
          IconButton(
            onPressed: () {
              homeBloc.add(HomeNavigateToCartEvent());
            },
            icon: Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listener: (context, state) {
          if (state is HomeItemCartedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Товар добавлен в корзину"),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.teal,
            ));
          } else if (state is HomeNavigateToCartActionState) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Cart()));
          }
        },
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case HomeLoadedSuccessState:
              final successState = state as HomeLoadedSuccessState;
              return Scaffold(
                body: ListView.separated(
                    itemCount: successState.pizzas.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      return PizzaTileWidget(
                          homeBloc: homeBloc,
                          pizzaDataModel: successState.pizzas[index]);
                    }),
              );
            case HomeErrorState:
              return Scaffold(
                body: Center(child: Text("Error")),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
