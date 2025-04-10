import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String typee;
  User(this.id, this.name, this.email, this.password, this.typee);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'typee': typee,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['name'],
      json['email'],
      json['password'],
      json['typee'],
    );
  }

  bool istypee() {
    return typee == 'admin';
  }

  bool isEmployee() {
    return typee == 'funcionario';
  }
}
