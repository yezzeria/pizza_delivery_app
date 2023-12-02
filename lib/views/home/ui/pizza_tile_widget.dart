import 'package:flutter/material.dart';
import 'package:pizza_delivery_app/views/home/bloc/home_bloc.dart';
import 'package:pizza_delivery_app/views/home/models/pizza_data_model.dart';

class PizzaTileWidget extends StatelessWidget {
  final PizzaDataModel pizzaDataModel;
  final HomeBloc homeBloc;
  const PizzaTileWidget(
      {super.key, required this.pizzaDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      //margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(pizzaDataModel.imageUrl),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  pizzaDataModel.name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: Text(
                  pizzaDataModel.description,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Text('от ' + pizzaDataModel.price.toString() + 'Р'),
                  SizedBox(
                    width: 60,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(80, 166, 132, 1),
                    ),
                    onPressed: () {
                      homeBloc.add(
                        HomeClickedOnCartEvent(pizzaDataModel: pizzaDataModel),
                      );
                    },
                    child: Text(
                      "Выбрать",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
