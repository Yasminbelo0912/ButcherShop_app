import 'dart:convert';

import 'package:acougue_app/models/meatproduct.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeatService {
  List<Meatproduct> _meats = [];

  Future<void> init() async {
    await loadMeats();
  }

  Future<void> loadMeats() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('meat_product');

    if (jsonString != null) {
      final List<dynamic> decodeList = jsonDecode(jsonString);
      _meats = decodeList.map((item) => Meatproduct.fromJson(item)).toList();
    }
  }

  Future<void> saveMeats() async {
    final prefs = await SharedPreferences.getInstance();
    final meatsListJson = _meats.map((meat) => meat.toJson()).toList();
    prefs.setString('meat_product', jsonEncode(meatsListJson));
  }

  void addMeat(Meatproduct meat) {
    _meats.add(meat);
    saveMeats();
  }

  void removeMeat(String id) {
    _meats.removeWhere((meat) => meat.id == id);

    saveMeats();
  }

  Future<void> updateMeat(Meatproduct meat) async {
    final index = _meats.indexWhere((u) => u.id == meat.id);
    if (index != -1) {
      _meats[index] = meat;

      await saveMeats();
    }
  }

  List<Meatproduct> get meats => _meats;
}
