import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:revision/Views/CarDetails.dart';
import 'package:revision/localStorage/CarsRepository.dart';

class SavedCars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: CarsRepository.getAllcars(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: SpinKitDoubleBounce(
              color: Colors.blue,
              size: 50.0,
            ));
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return _buildCarInfo(
                    context,
                    snapshot.data[index].brand,
                    snapshot.data[index].name,
                    snapshot.data[index].photo,
                    description: snapshot.data[index].description,
                  );
                });
          }
        });
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
