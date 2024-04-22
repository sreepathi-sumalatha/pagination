import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:news_with_pagination/model/news_model.dart';
import 'package:http/http.dart' as http;

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial ()) {
    on<FetchNews>(_onFetchNews);
  }

  Future<void> _onFetchNews( event,  emit) async {
    print("here!!!!!!!!!!!! ");
      emit(NewsLoadingState());
    try {
      print("response!!!!!!!!!!!! " );
      Response response = await http.get(Uri.parse('https://newsapi.org/v2/everything?limit=10&offset=0&apiKey=1d72a50bad1a4871a74830e1fa3a457a&q=tesla')
          );
      if (response.statusCode == 200) {
         print("response!!!!!!!!!!!! " + response.body.toString());
        final List<dynamic> newArticles =
         json.decode(response.body)['articles'];
        //  List<NewsModel> articles = json.decode(response.body)['articles'];
      //  print("response!!!!!!!!!!!! " + response.body.toString());
      print("data is------------ > $newArticles");
      emit(NewsLoadedState(articles: newArticles));
      print("Getting data....");
      } else {
        emit(NewsError());
      }
     
    } catch (e) {
      emit(NewsError());
    }
  }
}
