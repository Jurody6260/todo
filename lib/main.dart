import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:todo_1/pages/menu.dart';
import 'package:todo_1/functs/funcs.dart';

void main() => runApp(NeumorphicApp(
      debugShowCheckedModeBanner: false,
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      initialRoute: '/',
      routes: {'/': (context) => Home(storage: ListStorage())},
    ));
