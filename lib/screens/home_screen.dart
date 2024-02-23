import 'package:flutter/material.dart';
import 'package:online_61_news_project/models/news.dart';
import 'package:online_61_news_project/services/news_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<News> allNews = [];

  void getNews() async{
    List<News>? temp = await NewsServices().getTeslaNews();
    print(temp);
    if(temp != null){
      setState(() {
        allNews = temp;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          itemBuilder: (context, i){
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                allNews[i].imageUrl != null ?
                Image.network(
                  allNews[i].imageUrl.toString(),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ) : Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                  child: Center(
                    child: Icon(Icons.image_not_supported),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allNews[i].title.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        allNews[i].description.toString(),
                        style: TextStyle(
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }, 
          separatorBuilder: (context, i){
            return SizedBox(height: 20,);
          }, 
          itemCount: allNews.length,
        ),
      ),
    );
  }
}