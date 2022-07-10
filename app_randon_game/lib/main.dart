import 'package:app_randon_game/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  final ThemeData theme = ThemeData(
    primarySwatch: Colors.green,
    secondaryHeaderColor: Colors.green.shade700,
  );
  runApp(
    MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: theme,
    ),
  );
}
