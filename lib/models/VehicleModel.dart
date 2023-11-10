class VehicleModel {
  final int id;
  final String brand;
  final String model;

  VehicleModel({required this.id, required this.brand, required this.model});

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(id: json['id'], brand: json['brand'], model: json['model']);
  }
}
