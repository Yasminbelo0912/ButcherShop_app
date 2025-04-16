import 'package:acougue_app/models/meatproduct.dart';
import 'package:acougue_app/services/meat_service.dart';
import 'package:flutter/cupertino.dart';

class MeatManager extends ChangeNotifier {
  final MeatService _meatService = MeatService();

  List<Meatproduct> get meats => _meatService.meats;

  Future<void> init() async {
    await _meatService.init();
    notifyListeners();
  }

  Future<void> addMeat(Meatproduct meat) async {
    if (meat.id.isEmpty || meat.name.isEmpty) {
      throw Exception("Informações incompletas");
    }
    await _meatService.addMeat(meat);
    notifyListeners();
  }

  Future<void> removeMeat(Meatproduct meat) async {
    try {
      await _meatService.removeMeat(meat.id);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateMeat(Meatproduct meat) async {
    await _meatService.updateMeat(meat);
    notifyListeners();
  }

  Future<void> loadMeats() async {
    await _meatService.loadMeats();
    notifyListeners();
  }
}
