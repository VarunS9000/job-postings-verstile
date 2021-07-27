import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  dynamic dataMap={};
  @override
  Widget build(BuildContext context) {
    dataMap=dataMap.isEmpty?ModalRoute.of(context)!.settings.arguments:dataMap;
    return Scaffold(
      appBar: AppBar(
        title: Text(dataMap['name']),
        centerTitle: true,
      ),
      body: Container(
        child : Card(
          margin:EdgeInsets.all(20),
          shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
          ),
          child:SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
                child:Column(
                  children: [
                    Text(
                        dataMap['name'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 15,),
                    Html(data: dataMap['details'],)
                  ],
                )
            )

          )
        )
      ),

    );
  }
}
