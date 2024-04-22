import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:news_with_pagination/bloc/bloc/news_bloc.dart';
import 'package:news_with_pagination/model/news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> articles = [];
  List<NewsModel> newsList = [];
  int offset = 0;
  bool isLoading = false;
  bool hasMore = true;
  ScrollController _scrollController = ScrollController();

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

  @override
  void initState() {
    super.initState();
    NewsBloc().add(FetchNews());
    _scrollController.addListener(_loadMoreItems);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMoreItems() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(),
      child: Scaffold(
          appBar: AppBar(title: const Center(child: Text("News Data"))),
          body: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              print("state is !!!!!!!!!!! " + state.toString());
             if(state is NewsLoadedState) {
                return Text("NewsLoadedState");
              } else if (state is NewsLoadingState) {
                return Text("Success");
              }
            
              return ListView.builder(
                itemCount: articles.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < articles.length) {
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          articles[index]['title'],
                          maxLines: 2,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          articles[index]['description'],
                          maxLines: 2,
                        ),
                        leading: Image.network(
                          articles[index]['urlToImage'] ?? '',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      return Container();
                    }
                  }
                },
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
              );
              // } else if( state is NewsError){
              //   return Text(" There is a error occure");
              // }
            },
          )),
    );
  }
} 

/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> articles = [];
  int offset = 1;
  int page = 1;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  Future<void> fetchNews() async {
    setState(() {
      // articles.clear();
      isLoading = true;
    });
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?limit=10&offset=$offset&apiKey=1d72a50bad1a4871a74830e1fa3a457a&q=tesla'));
    if (response.statusCode == 200) {
      final List<dynamic> newArticles = json.decode(response.body)['articles'];
      setState(() {
        //   page++;
        // articles = articles + newArticles;

        articles.addAll(newArticles);
        isLoading = true;
        offset += newArticles.length;
      });
      //  setState(() {
      //   if (page == 1) {

      //     articles = newArticles;
      //   } else {

      //     articles.addAll(newArticles);
      //   }
      //   isLoading = false;
      // });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
    _scrollController.addListener(_loadMoreItems);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMoreItems() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent
        //  &&
        //     !isLoading
        ) {
      page = page + 1;
      fetchNews();
    }
    // if(_scrollController.position.maxScrollExtent== _scrollController.offset){
    //    fetchNews();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("News Data"))),
      body: ListView.builder(
        itemCount: articles.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < articles.length) {
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  articles[index]['title'],
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  articles[index]['description'],
                  maxLines: 2,
                ),
                leading: Image.network(
                  articles[index]['urlToImage'] ?? '',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            if (isLoading) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return Container();
            }
          }
        },
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
      ),
    );
  }
}*/
