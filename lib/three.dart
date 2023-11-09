import 'dart:convert';
import 'package:firstapi/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Three extends StatefulWidget {
  const Three({super.key});

  @override
  State<Three> createState() => _ThreeState();
}

class _ThreeState extends State<Three> {
  
  List<UserModel> userList = [];
  
  Future<List<UserModel>> getUserApi ()async{
    final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    //we will check the request
    if(response.statusCode == 200){
      for(Map i in data){                           //because in postman 'data' is present in an array
      //  print(i['name']);                         //for getting only one specific data 'name'
        userList.add(UserModel.fromJson(i));         //define i
      }
       return userList;
    }else{
      return userList;
    }  //if

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text('Json place users'),
     ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(                   //for calling getUserApi()
                future: getUserApi (),
                builder: (context,AsyncSnapshot<List<UserModel>> snapshot){        //list = <List<UserModel>>
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context,index){
                        return Card(//color: Colors.greenAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text('Name'),
                                //     Text(snapshot.data![index].name.toString()),
                                //   ],
                                // )
                                Reusablerow(title: 'Name', value: snapshot.data![index].name.toString()),
                                Reusablerow(title: 'Username', value: snapshot.data![index].username.toString()),
                                Reusablerow(title: 'Email', value: snapshot.data![index].email.toString()),
                                Reusablerow(title: 'Address', value: snapshot.data![index].address!.street.toString()),
                                Reusablerow(title: 'Geo', value: snapshot.data![index].address!.geo!.lng.toString())    //nested object lng in array
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
          )
        ],
      ),
    );
  }
}


class Reusablerow extends StatelessWidget {
  String title,value;

  Reusablerow({Key? key, required this.title, required this.value }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}

