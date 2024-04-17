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
  NewsBloc() : super(NewsInitialgit ()) {
    on<FetchNews>(_onFetchNews);
  }

  Future<void> _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
    print("here!!!!!!!!!!!! ");
     emit(NewsLoadingState());
    try {
      Response response = await http.get(Uri.parse('https://newsapi.org/v2/everything?limit=10&offset=0&apiKey=1d72a50bad1a4871a74830e1fa3a457a&q=tesla')
          );
      if (response.statusCode == 200) {
        final List<NewsModel> articles = json.decode(response.body)['articles'];
      
        emit(NewsLoadedState(articles: articles));
      } else {
        emit(NewsError());
      }
       print("response!!!!!!!!!!!! " + response.body.toString());
    } catch (e) {
      emit(NewsError());
    }
  }
}
