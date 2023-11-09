import 'dart:convert';
import 'package:firstapi/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signUp(String email,password) async{
    try {
      Response response =await post(
          Uri.parse('https://reqres.in/api/register'),     //http
          body: {
              'email': email,
              'password': password
      }
      );

      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print('Account Created Succesfully');
      }else{
        print('faild');
      }

    }catch(e){
      print(e.toString());
    }
    }

  void validate(){
    if(formkey.currentState!.validate())
    {
      print("ok");
    }else{
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp API'),
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'Email'
                ),

                validator: (val){
                  if(val!.isEmpty){
                    return "Required";
                  }if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(val)){
                    return 'Please Enter a valid Email';
                  }
                  else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: 'pass'
                ),
                validator: (val){
                  if(val!.isEmpty){
                    return "Required";
                  }else{
                    return null;
                  }
                },
              ),

              SizedBox(height: 20),

              GestureDetector(
                onTap: (){
                  signUp(emailController.text.toString(),
                      passwordController.text.toString());
                   validate();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                },
                child: Container(height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text('SignUp'),),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
