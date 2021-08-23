import 'package:flutter/material.dart';

class listCars extends StatefulWidget {
  List<Widget> cars = [];

  listCars(this.cars);

  @override
  _listCarsState createState() => _listCarsState();
}

class _listCarsState extends State<listCars> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.cars.length,
        itemBuilder: (BuildContext context, int index) {
          return widget.cars[index];
        });
  }
}
