import 'dart:convert';
import 'package:firstapi/home.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email,password) async{
    try {
      Response response =await post(
          Uri.parse('https://reqres.in/api/register'),
          body: {
            'email': email,
            'password': password
          }
      );

      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Login Succesfully');
      }else{
        print('faild');
      }
    }catch(e){
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login API'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
            //  controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Phone'
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
             // controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'pass'
              ),
            ),

            SizedBox(height: 20),

            GestureDetector(
              onTap: (){
                login(emailController.text.toString(), passwordController.text.toString());
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Container(height: 40,
                decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text('Login'),),
              ),
            )

          ],
        ),
      ),
    );
  }
}
