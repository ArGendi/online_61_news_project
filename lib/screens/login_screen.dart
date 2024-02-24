// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_61_news_project/cubits/login/login_cubit.dart';
import 'package:online_61_news_project/services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    var loginCubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: loginCubit.emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: loginCubit.passController,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              SizedBox(height: 20,),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state){
                  if(state is LoadingState){
                    return CircularProgressIndicator();
                  }
                  else{
                    return ElevatedButton(
                      onPressed: (){
                        loginCubit.onLogin(context);
                      },
                      child: Text("Login"),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}