import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pizza_delivery_app/data/cart_data.dart';
import 'package:pizza_delivery_app/views/home/models/pizza_data_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartDeleteItemEvent>(cartDeleteItemEvent);
    on<CartInitialEvent>(cartInitialEvent);
  }

  FutureOr<void> cartDeleteItemEvent(
      CartDeleteItemEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.pizzaDataModel);
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }
}
