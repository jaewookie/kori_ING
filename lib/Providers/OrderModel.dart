import 'package:flutter/material.dart';

class OrderModel with ChangeNotifier {
  List<String>? orderedItems;

  OrderModel({
    this.orderedItems,
  });

}