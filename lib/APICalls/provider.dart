import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class APICallsProvider extends ChangeNotifier{
  static const categoriesRoot= 'https://remotive.io/api/remote-jobs/categories';
  static const jobsRoot='https://remotive.io/api/remote-jobs?category=';
  dynamic categoriesList=[];
  dynamic jobsList=[] ;
  int currentIndex=0;


  get listOfCategories{
    return categoriesList;
  }

  get listOfJobs{
    return jobsList;
  }

  get indexNumber{
    return currentIndex;
  }



   getCategories() async{
    final response = await http.get(Uri.parse(categoriesRoot));
    if(response.statusCode==200){

      Map<String,dynamic> list=json.decode(response.body);
      //return list['jobs'];
      List<Categories> categories=[];
     list['jobs'].forEach((element)=>{
       categories.add(Categories(id: element['id'], name: element['name'], slug: element['slug']))
     });

     return categories;

    }

    return [];



  }

   getJobs(list,index)async{
    final response = await http.get(Uri.parse(jobsRoot+list[index].slug));
    if(response.statusCode==200){
      Map<String,dynamic> list=json.decode(response.body);
      dynamic objectList=[];

      list['jobs'].forEach((element)=>{

        objectList.add(Job(id: element['id'], url: element['url'], title: element['title'], companyName: element['company_name'], category: element['category'], type: element['job_type'], date: element['publication_date'], location: element['candidate_required_location'], salary: element['salary'], description: element['description']))
      });
      jobsList= objectList;

      return jobsList;
    }

    return 'Error';
  }

  getCurrentIndex(index){
    currentIndex=index;
    notifyListeners();
  }



}

class Categories{
  late int id;
  late String name;
  late String slug;

  Categories({required this.id,required this.name,required this.slug});
}

class Job{
  late int id;
  late String url;
  late String title;
  late String companyName;
  late String category;
  late String type;
  late String date;
  late String location;
  late String salary;
  late String description;

  Job({required this.id,required this.url,required this.title,required this.companyName,required this.category,required this.type,required this.date,required this.location,required this.salary,required this.description,});
}