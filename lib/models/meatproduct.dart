import 'package:flutter/foundation.dart';

class Meatproduct {
  final String employeeId;
  final String name;
  final DateTime validity;
  final String butcherShopId;
  final String butcherShop;
  final String id;

  Meatproduct(
    this.employeeId,
    this.name,
    this.validity,
    this.butcherShop,
    this.id,
    this.butcherShopId,
  );

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'name': name,
      'validity': validity.toIso8601String(),
      'butcherShopId': butcherShopId,
      'butcherShop': butcherShop,
      'id': id,
    };
  }

  factory Meatproduct.fromJson(Map<String, dynamic> json) {
    return Meatproduct(
      json['employeeId'],
      json['name'],
      DateTime.parse(json['validity']),
      json['butcherShopId'],
      json['butcherShop'],
      json['id'],
    );
  }
  bool get nextDueDate {
    final registeredDate = DateTime.now();
    final expirationDate = validity.difference(registeredDate).inDays;
    return expirationDate <= 5 && expirationDate >= 0;
  }
}
