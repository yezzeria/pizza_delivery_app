import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pizza_delivery_app/data/cart_data.dart';
import 'package:pizza_delivery_app/data/pizza_data.dart';
import 'package:pizza_delivery_app/views/home/models/pizza_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeNavigateToCartEvent>(homeNavigateToCartEvent);
    on<HomeClickedOnCartEvent>(homeClickedOnCartEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        pizzas: PizzaData.pizzaProducts
            .map((e) => PizzaDataModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: e['price'],
                imageUrl: e['imageUrl']))
            .toList()));
  }

  FutureOr<void> homeNavigateToCartEvent(
      HomeNavigateToCartEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartActionState());
  }

  FutureOr<void> homeClickedOnCartEvent(
      HomeClickedOnCartEvent event, Emitter<HomeState> emit) {
    cartItems.add(event.pizzaDataModel);
    emit(HomeItemCartedActionState());
  }
}
