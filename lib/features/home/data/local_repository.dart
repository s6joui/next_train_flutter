import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalRepository {
  Future<String?> getStationName();
  void setStationName(String stationName);
  void clear();
}

class PreferencesLocalRepository extends LocalRepository {
  static const stationKey = 'station';

  String? _stationName;

  @override
  Future<String?> getStationName() async {
    final prefs = await SharedPreferences.getInstance();
    return _stationName ?? prefs.getString(PreferencesLocalRepository.stationKey);
  }

  @override
  void setStationName(String stationName) async {
    _stationName = stationName;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesLocalRepository.stationKey, stationName);
  }

  @override
  void clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
