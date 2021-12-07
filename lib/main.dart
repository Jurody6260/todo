import 'package:flutter/material.dart';
import 'pages/menu.dart';
import 'functs/funcs.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => Home(storage: ListStorage())},
    ));
