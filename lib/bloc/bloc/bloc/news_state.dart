part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
  
  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {}
class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  List<dynamic> articles;
  

  NewsLoadedState({required this.articles});
  @override
  List<Object> get props => [articles];
  
}

class NewsError extends NewsState {}