import 'package:flutter/material.dart';

class ProductModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode priceFocusNode = FocusNode();
  FocusNode quantityFocusNode = FocusNode();
}
