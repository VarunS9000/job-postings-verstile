import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verstile_assignment/APICalls/provider.dart';
import 'package:verstile_assignment/service/search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic dataList;
  int currentIndex=0;
  dynamic listForSearchClass=[];
  getJobs(BuildContext context,list,index){
    Provider.of<APICallsProvider>(context,listen: true).getJobs(list, index);
  }




  @override
  Widget build(BuildContext context) {

    dataList=[];
    dataList=dataList.isEmpty?ModalRoute.of(context)!.settings.arguments:dataList;


    return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  if(listForSearchClass.length!=0){
                    showSearch(
                        context: context, delegate: SearchJobs(jobs:listForSearchClass));
                  }

                },
              )
            ],
          ),
          body:Container(


              child: Padding(
                  padding: EdgeInsets.all(20),
                  child:Column(

                    children: [
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                            itemCount: dataList.length,
                            scrollDirection: Axis.horizontal,

                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){


                                  Provider.of<APICallsProvider>(context,listen: false).getCurrentIndex(index);
                                  currentIndex=Provider.of<APICallsProvider>(context,listen: false).indexNumber;
                                  listForSearchClass=[];


                                },
                                child: Container(
                                  color: index==currentIndex?Colors.black:Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child:Center(
                                      child: Text(
                                        dataList[index].name,
                                        style: TextStyle(
                                          color: index==currentIndex?Colors.white:Colors.black,
                                        ),
                                      ),
                                    )
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(dataList[currentIndex].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text('Tap on the card to get a detail description of the role'),

                      Expanded(child:FutureBuilder(
                          future: Provider.of<APICallsProvider>(context).getJobs(dataList, currentIndex),
                          builder: (context,AsyncSnapshot<dynamic> snapShot){

                            if(snapShot.hasData && (snapShot.data[0].category==dataList[currentIndex].name)){
                             listForSearchClass=snapShot.data;

                              return ListView.builder(
                                  itemCount: snapShot.data.length,
                                  itemBuilder: (context,index){
                                    return GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(context, '/details',arguments: {
                                          'name':snapShot.data[index].companyName,
                                          'details':snapShot.data[index].description
                                        });
                                      },
                                      child: Card(
                                          margin:EdgeInsets.all(20),
                                          shape:RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0)
                                          ),
                                          shadowColor: Colors.blueGrey,
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child:Text(
                                                      snapShot.data[index].title,
                                                      style:TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20.0,

                                                      )
                                                  ),
                                                ),

                                                SizedBox(height: 5,),
                                                Text('Company name : ${snapShot.data[index].companyName}'),
                                                SizedBox(height: 5,),
                                                Text('Job Type : ${snapShot.data[index].type}'),
                                                SizedBox(height: 5,),
                                                Text('Location : ${snapShot.data[index].location}'),
                                                SizedBox(height: 5,),
                                                Text('Salary : ${snapShot.data[index].salary==""?'Not mentioned':snapShot.data[index].salary}')

                                              ],
                                            ),
                                          )
                                      ),
                                    );
                                  }
                              );





                            }


                            return Card(
                              margin:EdgeInsets.all(20),
                              shape:RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)
                              ),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );

                          }
                      )
                      )








                    ],
                  )
              )
          )
      );

  }
}
