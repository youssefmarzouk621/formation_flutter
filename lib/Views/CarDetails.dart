import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:revision/Models/Cars.dart';
import 'package:revision/localStorage/CarsRepository.dart';

class CarDetails extends StatefulWidget {
  final String brand;
  final String name;
  final String photo;
  String description;

  CarDetails(this.brand, this.name, this.photo, {this.description});

  @override
  _CarDetailsState createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  bool flag = false;

  @override
  void initState() {
    super.initState();
    CarsRepository.getCarByName(widget.name).then((car) {
      if (car.name == widget.name) {
        setState(() {
          flag = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.car_rental),
              SizedBox(
                width: 5,
              ),
              Text("Details"),
            ],
          ),
          actions: [
            FlatButton(
                onPressed: () async {
                  if (flag == false) {
                    CarsRepository.addCarToFavorite(Cars(widget.name,
                            widget.brand, widget.photo, widget.description))
                        .then((result) {
                      setState(() {
                        flag = !flag;
                        print("flag :$flag");
                      });

                      EasyLoading.showSuccess("voiture reservée");
                    });
                  } else {
                    CarsRepository.deleteProductFromFavorite(widget.name)
                        .then((value) {
                      setState(() {
                        flag = !flag;
                        print("flag :$flag");
                      });

                      EasyLoading.showSuccess("Reservation annulée");
                    });
                  }
                },
                child: flag == false
                    ? Row(
                        children: [
                          Icon(
                            Icons.add_road_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            "Reserver",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Icon(
                            Icons.edit_road_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            "Annuler",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
                tag: widget.photo,
                child: Image.asset(
                  widget.photo,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                )),
            Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Model :${widget.brand} ${widget.name}"),
                    SizedBox(
                      height: 5,
                    ),
                    widget.description != null
                        ? Text(
                            "Description :${widget.description}",
                            style: TextStyle(fontSize: 15.5),
                          )
                        : Text("")
                  ],
                )),
          ],
        ));
  }
}
