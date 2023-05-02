
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class CsvReader {

  Future<List<List<dynamic>>> readFile(String path) async {
      var result = await rootBundle.loadString(path);
      const converter = CsvToListConverter(fieldDelimiter: ';');
      return converter.convert(result);
  }

}