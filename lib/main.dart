import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verstile_assignment/APICalls/provider.dart';
import 'package:verstile_assignment/screens/home.dart';
import 'package:verstile_assignment/screens/loading.dart';
import 'package:verstile_assignment/screens/details.dart';


void main(){
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: APICallsProvider())
      ],
    child: MaterialApp(
      initialRoute: '/loading',
      routes: {
        '/home':(context)=>Home(),
        '/loading':(context)=>Loading(),
        '/details':(context)=>Details()
      },
    ))
  );
}