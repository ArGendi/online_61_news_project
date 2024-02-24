import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_61_news_project/cubits/news/news_cubit.dart';
import 'package:online_61_news_project/models/news.dart';
import 'package:online_61_news_project/services/news_services.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NewsCubit>(context).getNews();
  }

  @override
  Widget build(BuildContext context) {
    var newsCubit = BlocProvider.of<NewsCubit>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state){
            if(state is LoadingState){
              return Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade700,
                  highlightColor: Colors.grey.shade400,
                  child: Text(
                    'Getting your news',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              );
            }
            else if(state is SuccessState){
              return ListView.separated(
                itemBuilder: (context, i){
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      newsCubit.articles[i].imageUrl != null ?
                      Image.network(
                        newsCubit.articles[i].imageUrl.toString(),
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
                              newsCubit.articles[i].title.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              newsCubit.articles[i].description.toString(),
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
                itemCount: newsCubit.articles.length,
              );
            }
            else if(state is FailState){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Try again later !!"),
                    ElevatedButton(
                      onPressed: (){
                        newsCubit.getNews();
                      }, 
                      child: Text("Another chance"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }
            else{
              return Container();
            }
          },
        ),
      ),
    );
  }
}