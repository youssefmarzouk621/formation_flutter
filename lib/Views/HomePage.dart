import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:revision/Views/listCars.dart';
import 'package:revision/Views/savedCars.dart';

import 'CarDetails.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String marque;
  String modele;
  String description;
  String quantite;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Widget> cars = [];
  @override
  void initState() {
    interfaces.add(listCars(cars));
    interfaces.add(SavedCars());
    super.initState();

    cars.add(
      _buildCarInfo(context, "Ford", "Mustang 2020", "assets/images/stang.png",
          description:
              "The 2021 Mustang continues its legacy, engineered for quick turns & spirited drives. ... A 2021 Ford Mustang Mach 1 being driven on a track ..."),
    );
    cars.add(
      _buildCarInfo(context, "Corvette", "C8", "assets/images/corvette.jpeg"),
    );

    cars.add(
      _buildCarInfo(context, "Ferrari", "458", "assets/images/ferrari.jpeg"),
    );

    cars.add(
        _buildCarInfo(context, "Honda", "NSX", "assets/images/honda.jpeg"));
  }

  int _bottomIndex = 0;

  List<Widget> interfaces = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('P3 - Routes'),
      ),
      body: interfaces[_bottomIndex],
      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Choose an option"),
          ),
          body: Column(
            children: [
              ListTile(
                title: Text("Option 1"),
                onTap: () {
                  print("go to");
                },
              ),
              ListTile(
                title: Text("Option 2"),
                onTap: () {
                  print("go to");
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_road),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                height: MediaQuery.of(context).size.height - 100,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Ajouter une nouvelle voiture",
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              _buildTextField(
                                  Icons.car_rental, "Marque de la voiture",
                                  // ignore: missing_return
                                  validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Champ obligatoire';
                                }
                              }, onSaved: (String value) {
                                marque = value;
                              }),
                              _buildTextField(Icons.car_rental, "Modele",
                                  // ignore: missing_return
                                  validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Champ obligatoire';
                                }
                              }, onSaved: (String value) {
                                modele = value;
                              }),
                              _buildTextField(Icons.car_rental, "Description",
                                  // ignore: missing_return
                                  validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Champ obligatoire';
                                }
                              }, onSaved: (String value) {
                                description = value;
                              }),
                              _buildTextField(Icons.car_rental, "quantite",
                                  // ignore: missing_return
                                  validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Champ obligatoire';
                                }
                              }, onSaved: (String value) {
                                quantite = value;
                              }),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (!_formKey.currentState.validate()) {
                                      return;
                                    }

                                    _formKey.currentState.save();

                                    EasyLoading.show(status: 'loading...');

                                    await Future.delayed(Duration(seconds: 3));
                                    setState(() {
                                      cars.add(_buildCarInfo(context, marque,
                                          modele, "assets/images/audi.jpeg"));
                                    });
                                    EasyLoading.showSuccess("success");
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                      width: 100,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add),
                                          Text("Ajouter"),
                                        ],
                                      )))
                            ],
                          ))
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: "Cars",
            icon: Icon(Icons.list),
          ),
          BottomNavigationBarItem(label: "Saved", icon: Icon(Icons.bookmark)),
        ],
        currentIndex: _bottomIndex,
        onTap: (int value) {
          setState(() {
            _bottomIndex = value;
          });
        },
      ),
    );
  }

  Padding _buildTextField(IconData icon, String hintText,
      {@required String Function(String) validator,
      @required void Function(String) onSaved}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        // ignore: missing_return
        validator: validator,
        onSaved: onSaved,
      ),
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
