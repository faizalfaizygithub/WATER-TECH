import 'package:flutter/material.dart';
import 'package:water_tech/model/Service.dart';

class HomeProviderController extends ChangeNotifier {
  final List<Service> _service = [
    Service(name: '500 LTR', imagePath: 'assets/photo/pic.webp', price: 599),
    Service(name: ' 750 LTR', imagePath: 'assets/photo/pic.webp', price: 699),
    Service(name: ' 1000 LTR', imagePath: 'assets/photo/pic.webp', price: 799),
    Service(
      name: '2000 LTR',
      imagePath: 'assets/photo/pic.webp',
      price: 999,
    ),
    Service(
        name: 'Under 5000 LTR',
        imagePath: 'assets/photo/pic.webp',
        price: 3590),
    Service(
        name: 'Capsule Tank',
        imagePath: 'assets/photo/capsule.png',
        price: 1199)
  ];
// get service list
  List<Service> get serviceList => _service;

// create cart list

  final List<Service> _cart = [];

  //get cart

  List<Service> get cart => _cart;

  final String _date = '';

  String get date => _date;
}
