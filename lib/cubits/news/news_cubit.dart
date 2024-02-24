import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:online_61_news_project/models/news.dart';
import 'package:online_61_news_project/services/news_services.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  List<News> articles = [];

  NewsCubit() : super(NewsInitial());

  void getNews() async{
    emit(LoadingState());
    List<News>? response = await NewsServices().getNews();
    if(response != null){
      articles = response;
      emit(SuccessState());
    }
    else{
      emit(FailState());
    }
  }
}
