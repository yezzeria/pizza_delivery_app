part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeNavigateToCartEvent extends HomeEvent {}

class HomeClickedOnCartEvent extends HomeEvent {
  final PizzaDataModel pizzaDataModel;
  HomeClickedOnCartEvent({
    required this.pizzaDataModel,
  });
}
