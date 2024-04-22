import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<FetchNews>(_onFetchNews);
  }

  Future<void> _onFetchNews(event, emit) async {
    emit(NewsLoadingState());
    try {
      Response response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?limit=10&offset=0&apiKey=1d72a50bad1a4871a74830e1fa3a457a&q=tesla'));
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

/// safe side code.........
// Future<void> fetchNews() async {
  //   // setState(() {
  //   //   isLoading = true;
  //   // });
  //   Response response = await http.get(Uri.parse(
  //       'https://newsapi.org/v2/everything?limit=10&offset=$offset&apiKey=1d72a50bad1a4871a74830e1fa3a457a&q=tesla'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> newArticles =
  //         json.decode(response.body)['articles'];
  //     setState(() {
  //       articles.addAll(newArticles);
  //       isLoading = false;
  //       offset += newArticles.length;
  //     });
  //   } else {
  //     throw Exception('Failed to load news');
  //   }
  // }