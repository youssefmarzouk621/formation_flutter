import 'package:flutter/material.dart';

import 'CarDetails.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCarInfo(
            context, "Ford", "Mustang 2020", "assets/images/stang.png",
            description:
                "The 2021 Mustang continues its legacy, engineered for quick turns & spirited drives. ... A 2021 Ford Mustang Mach 1 being driven on a track ..."),
        _buildCarInfo(context, "Corvette", "C8", "assets/images/corvette.jpeg"),
        _buildCarInfo(context, "Ferrari", "458", "assets/images/ferrari.jpeg"),
        _buildCarInfo(context, "Honda", "NSX", "assets/images/honda.jpeg"),
      ],
    );
  }

  Widget _buildCarInfo(
      BuildContext context, String brand, String name, String photo,
      {String description}) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CarDetails(
                        brand,
                        name,
                        photo,
                        description: description,
                      )));
        },
        child: Container(
          child: Row(
            children: [
              Hero(
                  tag: photo,
                  child: Image.asset(
                    photo,
                    width: 150,
                    height: 100,
                  )),
              Padding(padding: EdgeInsets.only(left: 10)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(brand), Text(name)],
              )
            ],
          ),
        ),
      ),
    );
  }
}
