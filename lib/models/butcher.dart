class Butcher {
  final String id;
  final String name;
  final String endereco;

  Butcher(this.id, this.name, this.endereco);

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'endereco': endereco};
  }

  factory Butcher.fromJson(Map<String, dynamic> json) {
    return Butcher(json['id'], json['name'], json['endereco']);
  }
}
