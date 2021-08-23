import 'package:revision/Models/Cars.dart';
import 'package:revision/localStorage/DatabaseFactory.dart';

class CarsRepository {
  static Future<List<Cars>> getAllcars() async {
    Future.delayed(Duration(seconds: 2));
    await DatabaseFactory().initDatabase();
    final sql = '''
      SELECT * FROM Cars
    ''';

    final data = await db.rawQuery(sql);
    List<Cars> cars = [];

    for (final node in data) {
      final car = Cars.fromJson(node);
      cars.add(car);
    }

    return cars;
  }

  static Future<void> addCarToFavorite(Cars car) async {
    await DatabaseFactory().initDatabase();

    final sql = '''INSERT INTO Cars
    (
      "name",
      "brand",
      "photo",
      "description"
    )
    VALUES (?,?,?,?)''';

    List<dynamic> params = [car.name, car.brand, car.photo, car.description];

    final result = await db.rawInsert(sql, params);
    print("car inserted");
  }

  static Future<Cars> getCarByName(String name) async {
    await DatabaseFactory().initDatabase();

    final sql = '''SELECT * FROM Cars
    WHERE "name" = ?
    ''';

    List<dynamic> params = [name];
    final data = await db.rawQuery(sql, params);
    List<Cars> cars = [];

    for (final node in data) {
      final car = Cars.fromJson(node);
      cars.add(car);
    }

    return cars.first;
  }

  static Future<void> deleteProductFromFavorite(String name) async {
    await DatabaseFactory().initDatabase();

    final sql = '''DELETE FROM Cars
    WHERE "name" = ?
    ''';

    List<dynamic> params = [name];
    final result = await db.rawDelete(sql, params);

    print("car deleted");
  }

/*static Future<void> updateCar(Car car) async {
    final sql = '''
    UPDATE ${DatabaseCreator.CarsTable}
    SET "urlImg" = ?,
        "name" = ?,
        "make" = ?
    WHERE 'id' = ?
    ''';

    List<dynamic> params = [car.urlImg, car.name, car.make, car.id];
    final result = await db.rawUpdate(sql, params);

    print("car updated");
  }*/

}
