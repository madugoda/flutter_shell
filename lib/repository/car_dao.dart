import 'package:flutter_shell/repository/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_shell/repository/car_provider.dart';

class CarDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_brand TEXT, '
      '$_year TEXT, '
      '$_km TEXT)';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _brand = 'brand';
  static const String _year = 'year';
  static const String _km = 'km';

  Map<String, String> toMap(CarSpecs carSpecs) {
    final Map<String, String> carMap = {};
    carMap[_name] = carSpecs.carName;
    carMap[_brand] = carSpecs.carBrand;
    carMap[_year] = carSpecs.carYear;
    carMap[_km] = carSpecs.carKm;
    return carMap;
  }

  List<CarSpecs> toList(List<Map<String, dynamic>> carMap) {
    final List<CarSpecs> specs = [];
    for (Map<String, dynamic> line in carMap) {
      final CarSpecs spec = CarSpecs(
          carName: line[_name],
          carBrand: line[_brand],
          carYear: line[_year],
          carKm: line[_km]);
      specs.add(spec);
    }
    return specs;
  }

  save(CarSpecs carSpecs) async {
    final Database carDatabase = await getDatabase();
    carDatabase.delete(_tablename);
    Map<String, String> carMap = toMap(carSpecs);
    return await carDatabase.insert(
      _tablename,
      carMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CarSpecs>> findAll() async {
    final Database carDatabase = await getDatabase();
    final List<Map<String, dynamic>> result =
        await carDatabase.query(_tablename);
    return toList(result);
  }
}
