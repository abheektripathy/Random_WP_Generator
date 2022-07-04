import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import './randomwords.dart'; // we imported the fucking class here so main class isnt cluttered.

void main() => runApp(RandomWordsApp());

class RandomWordsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.black),
        home: RandomWords()); //this dosent work for me apparently
  }
}
