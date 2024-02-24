import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:online_61_news_project/screens/home_screen.dart';
import 'package:online_61_news_project/services/auth_services.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  
  LoginCubit() : super(LoginInitial());

  void onLogin(BuildContext context) async{
    emit(LoadingState());
    var response = await AuthServices().login(emailController.text, passController.text);
    if(response != null){
      emit(SuccessState());
      print(response["token"]);
      if(context.mounted){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    }
    else{
      emit(FailState());
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wrong email or password'), backgroundColor: Colors.red,)
        );
      }
    }
  }
}
