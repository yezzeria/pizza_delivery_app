part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedSuccessState extends HomeState {
  final List<PizzaDataModel> pizzas;

  HomeLoadedSuccessState({required this.pizzas});
}

final class HomeErrorState extends HomeState {}

final class HomeNavigateToCartActionState extends HomeActionState {}

final class HomeItemCartedActionState extends HomeActionState {}
