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
    on<LoadMoreNews>(_onLoadMoreNews);
  }
  bool _hasMore = true;
  int _currentPage = 1;
  List myList = [];
  int initLoadCount = 10;
  int loadMoreCount = 0;
  int loadedLastIndex = 0;

  Future<void> _onFetchNews(event, emit) async {
    List<dynamic> myList = [];
    int initLoadCount = 10;
    int loadMoreCount = 0;
    int loadedLastIndex = 0;
    // List<dynamic> articles =[];
    // bool isLoading = true;
    // if (!_hasMore) return;
    _currentPage = 1;
    emit(NewsLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 2));
      Response response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?pageSize=10&page=$_currentPage&apiKey=1d72a50bad1a4871a74830e1fa3a457a&q=tesla'));
      if (response.statusCode == 200) {
        final List<dynamic> newArticles =
            json.decode(response.body)['articles'];
        myList = List.generate(initLoadCount, (i) => "Item : ${i + 1}");
        loadMoreCount = initLoadCount;
        myList.addAll(newArticles);
        emit(NewsLoadedState(articles: myList));
//  articles.addAll(newArticles);
//       isLoading = false;
//       _currentPage += newArticles.length;
        // if (newArticles.isEmpty) {
        //   _hasMore = false;
        // }
        emit(NewsLoadedState(articles: newArticles));
      } else {
        emit(NewsError());
      }
    } catch (e) {
      emit(NewsError());
    }
  }

  Future<void> _onLoadMoreNews(event, emit) async {
    List<dynamic> myList = [];
    int initLoadCount = 10;
    int loadMoreCount = 0;
    int loadedLastIndex = 0;
    _hasMore = true;
    _currentPage++;
    //  emit(NewsLoadingState());
    try {
      Response response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?pageSize=10&page=$_currentPage&apiKey=1d72a50bad1a4871a74830e1fa3a457a&q=tesla'));
      if (response.statusCode == 200) {
        final List<dynamic> newArticles =
            json.decode(response.body)['articles'];

        loadMoreCount = initLoadCount;
        myList += List.generate(
            loadMoreCount, (i) => "Item : ${loadedLastIndex + i + 1}");
        myList.addAll(newArticles);
        if (newArticles.isEmpty) {
          _hasMore = false;
        }
        emit(NewsLoadedState(articles: myList));
        //  List<NewsModel> articles = json.decode(response.body)['articles'];
        //  print("response!!!!!!!!!!!! " + response.body.toString());
        emit(NewsLoadedState(articles: newArticles));
      } else {
        emit(NewsError());
      }
    } catch (e) {
      emit(NewsError());
    }
  }
}
