import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Two extends StatefulWidget {
  const Two({super.key});

  @override
  State<Two> createState() => _TwoState();
}

class _TwoState extends State<Two> {

  List<Photos> photosList = [];       
  
  Future<List<Photos>> getPhotos ()async{            //Fetching data through api key/link
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    print(data);
    if(response.statusCode == 200){  //here we are fetching data through custom model 'Photos' which is created after scaffold function
      for(Map i in data){
        Photos photos = Photos(title: i['title'], url: i['url'],id: i['id']);
        photosList.add(photos);
      }  //for
      return photosList;
    }else{
      return photosList;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Users'),
      ),
      body: Column(
        children: [
            Expanded(
              child: FutureBuilder(
                  future:  getPhotos(),
                  builder: (context, AsyncSnapshot<List<Photos>> snapshot){
                return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                      ),
                      subtitle: Text(snapshot.data![index].title.toString()),
                      title: Text('Notes id:'+snapshot.data![index].id.toString()),
                    ),
                  );
                });
                  }),
            )
        ],
      ),
    );
  }
}

class Photos {              //own custom Model
   String title,url;
   int id;
   Photos({required this.title,required this.url,required this.id});
}