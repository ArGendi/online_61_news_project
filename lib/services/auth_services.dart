import 'package:dio/dio.dart';

class AuthServices{
   Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://project1.amit-learning.com/api/",
      contentType: "application/json",
      receiveDataWhenStatusError: true,
      followRedirects: true,
    ),
  );

  Future< Map<String, dynamic>? > login(String email, String password) async{
   try{
     var response = await dio.post("auth/login", data: {
        "email": email,
        "password": password,
      },);

      if(response.statusCode! >= 200 && response.statusCode! < 300){
        return response.data;
      }
      else{
        return null;
      }
   }
   catch(e){
      return null;
   }
  }
}

