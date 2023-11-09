import 'dart:convert';
import 'package:firstapi/login.dart';
import 'package:firstapi/models/postmodel.dart';
import 'package:firstapi/signup.dart';
import 'package:firstapi/three.dart';
import 'package:firstapi/two.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List<PostModel> PostList = [];                                //for storing data

  Future<List<PostModel>> getPostApi()async{                   //Fetching data through api key/link
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
     var data = jsonDecode(response.body.toString());              //decode json
     if(response.statusCode == 200){                            //if code 200 mean request valid
     for(Map i in data){
       PostList.add(PostModel.fromJson(i));                      //fetching data from json
     }
     return PostList;
    }else{
      return PostList;
    }
  }         //Future


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API data'),
      ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text('Mohit Verma',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
              ),
              Column(
                children: [
                  ListTile(
                    title: Text('First page'),
                    leading: Icon(Icons.list),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Two()));
                    },
                  ),

                  ListTile(
                    title: Text('Second page'),
                    leading: Icon(Icons.list),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Three()));
                    },
                  ),

                  ListTile(
                    title: Text('SignUp'),
                    leading: Icon(Icons.account_box),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Sign()));
                    },
                  ),

                  ListTile(
                    title: Text('Login'),
                    leading: Icon(Icons.login),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
                    },
                  ),
                ],
              )
            ],
          ),
        ),



        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Column(
              children: [
                  Expanded(
                    child: FutureBuilder(future: getPostApi(),
                        builder: (context, snapshot){
                      if(!snapshot.hasData){
                      return Center(child: Text('Loading...'));
                      }else{
                        return ListView.builder(
                            itemCount: PostList.length,
                            itemBuilder: (context, index){
                              return Card(//color: Colors.greenAccent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Text('Title',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                    Text(PostList[index].title.toString()),
                                    SizedBox(height: 5),
                                    Text('Description',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                    Text(PostList[index].title.toString()),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              );
                            },);
                          }
                        }
                    ),
                  )
              ],
            ),
          ),
        ),
    );
  }
}
