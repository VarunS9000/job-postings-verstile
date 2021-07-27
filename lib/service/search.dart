import 'package:flutter/material.dart';
import 'package:verstile_assignment/APICalls/provider.dart';

class SearchJobs extends SearchDelegate{
  List<Job> jobs;
  String camelCase(String text) {
    if (text.length > 0) {
      return text[0].toUpperCase() + text.substring(1);
    }

    return "";
  }
  SearchJobs({required this.jobs});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Job> filteredList= jobs.where(
            (element) => element.title.contains(camelCase(query.trim())))
        .toList();
    return Container(

      child: Column(
        children: [
          SizedBox(height: 10,),
          Text(filteredList[0].category,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          ),
          SizedBox(height: 5,),
          Text('Tap on the card to get a detail description of the role'),
          Expanded(
              child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/details',arguments: {
                          'name':filteredList[index].companyName,
                          'details':filteredList[index].description
                        });
                      },
                      child: Card(
                          margin:EdgeInsets.all(20),
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Center(
                                  child:Text(
                                      filteredList[index].title,
                                      style:TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,

                                      )
                                  ),
                                ),

                                SizedBox(height: 5,),
                                Text('Company name : ${filteredList[index].companyName}'),
                                SizedBox(height: 5,),
                                Text('Job Type : ${filteredList[index].type}'),
                                SizedBox(height: 5,),
                                Text('Location : ${filteredList[index].location}')
                              ],
                            ),
                          )

                      ),
                    );

                  }
              ),
          )
        ],
      )


    );
  }
  
  
}