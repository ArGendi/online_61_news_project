import 'package:dio/dio.dart';
import 'package:online_61_news_project/models/news.dart';

class NewsServices{

  Future<List<News>?> getTeslaNews() async{
    try{
      List<News> listOfNews = [];
      Dio dio = Dio();
      print("ready");
      Response response = await dio.get("https://newsapi.org/v2/everything?q=tesla&from=2024-01-23&sortBy=publishedAt&apiKey=7cbef3e0859e47bea7efc555e5a5b35e");
      print("done: ${response.statusCode}");
      if(response.statusCode! >= 200 && response.statusCode! < 300){
        Map<String,dynamic> body = response.data;
        for(var article in body["articles"]){
          News news = News.fromJson(article);
          listOfNews.add(news);
        }
        return listOfNews;
      }
      else{
        return null;
      }
    }
    catch(e){
      print("Error : $e");
      return null;
    }
  }

}