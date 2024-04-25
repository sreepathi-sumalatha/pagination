part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {
  // List <dynamic> oldArticles;
  //  bool isFirstFetch ;
  //  NewsLoadingState({required this.oldArticles, this.isFirstFetch=false});
  // @override
  // List<Object> get props => [oldArticles, isFirstFetch];
}

class NewsLoadedState extends NewsState {
  List<dynamic> articles;

  NewsLoadedState({required this.articles});
  @override
  List<Object> get props => [articles];
}

class NewsError extends NewsState {}
