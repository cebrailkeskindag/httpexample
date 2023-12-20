import 'package:flutter/material.dart';
import 'package:httpexample/screens/product_screen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: ProductScreen(),
    ),
  ));
}
