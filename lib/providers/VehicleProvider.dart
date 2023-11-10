import 'package:flutter/material.dart';
import 'package:proy1/models/VehicleModel.dart';

class VehicleProvider extends ChangeNotifier {
  VehicleModel? _vehicle;

  VehicleModel? get vehicle => _vehicle;

  void setVehicle(VehicleModel vehicle) {
    _vehicle = vehicle;
    notifyListeners();
  }
}
