import 'dart:convert';

import 'package:acougue_app/models/butcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButcherService {
  List<Butcher> _butchers = [];

  Future<void> init() async {
    await loadButcher();
  }

  Future<void> loadButcher() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('butcher');

    if (jsonString != null) {
      final List<dynamic> decodeList = jsonDecode(jsonString);
      _butchers = decodeList.map((item) => Butcher.fromJson(item)).toList();
    }
  }

  Future<void> saveButcher() async {
    final prefs = await SharedPreferences.getInstance();
    final butcherListJson = _butchers.map((b) => b.toJson()).toList();

    prefs.setString('butcher', jsonEncode(butcherListJson));
  }

  Future<void> addButcher(Butcher butcher) async {
    _butchers.add(butcher);

    await saveButcher();
  }

  Future<void> removeButcher(String id) async {
    _butchers.removeWhere((butcher) => butcher.id == id);

    await saveButcher();
  }

  Future<void> updateButcher(Butcher butcher) async {
    final index = _butchers.indexWhere((u) => u.id == butcher.id);
    if (index != -1) {
      _butchers[index] = butcher;

      await saveButcher();
    }
  }

  List<Butcher> get butchers => _butchers;
}
