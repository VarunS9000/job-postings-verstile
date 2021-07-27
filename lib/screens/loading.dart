import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verstile_assignment/APICalls/provider.dart';
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  getData(BuildContext context) async{
    dynamic list= await Provider.of<APICallsProvider>(context).getCategories();
    Navigator.pushReplacementNamed(context, '/home',arguments: list);
  }

  @override
  Widget build(BuildContext context) {
    getData(context);
    return Scaffold(
      body: Center(
        child:CircularProgressIndicator()
      ),
    );
  }
}
