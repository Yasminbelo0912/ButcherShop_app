import 'package:acougue_app/models/butcher.dart';
import 'package:acougue_app/services/butcher_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ButcherManager extends ChangeNotifier {
  final ButcherService _butcherService = ButcherService();

  List<Butcher> get butchers => _butcherService.butchers;

  Future<void> init() async {
    await _butcherService.init();
    notifyListeners();
  }

  Future<void> loadButcher() async {
    await _butcherService.loadButcher();
    notifyListeners();
  }

  Future<void> addButcher(Butcher butcher) async {
    if (butcher.id.isEmpty ||
        butcher.name.isEmpty ||
        butcher.endereco.isEmpty) {
      throw Exception("Informações incompletas");
    }
    await _butcherService.addButcher(butcher);
    notifyListeners();
  }

  Future<void> removeButcher(Butcher butcher) async {
    try {
      await _butcherService.removeButcher(butcher.id);
      notifyListeners();
    } catch (e) {
      print("Eroos ao remover açougue: $e");
      throw Exception("Erro o remover açougue: $e");
    }
  }

  Future<void> updateButcher(Butcher butcher) async {
    if (butcher.id.isEmpty ||
        butcher.name.isEmpty ||
        butcher.endereco.isEmpty) {
      throw Exception("Informações incompletas");
    }
    await _butcherService.updateButcher(butcher);
    notifyListeners();
  }
}
