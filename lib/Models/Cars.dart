class Cars {
  String name;
  String brand;
  String photo;
  String description;

  Cars(
    this.name,
    this.brand,
    this.photo,
    this.description,
  );

  Cars.fromJson(Map<String, dynamic> json) {
    this.name = json['name'] as String;
    this.brand = json['brand'] as String;
    this.photo = json['photo'] as String;
    this.description = json['description'] as String;
  }
}
