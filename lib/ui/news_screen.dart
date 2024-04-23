import 'package:flutter/material.dart';
import 'package:news_with_pagination/bloc/bloc/bloc/news_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int offset = 0;
  bool isLoading = false;
  // bool hasMore = true;
  ScrollController _scrollController = ScrollController();
  late NewsBloc newsBloc;

  @override
  void initState() {
    super.initState();
    newsBloc = NewsBloc();
    newsBloc.add(const FetchNews());

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
        !isLoading) {
      newsBloc.add(const LoadMoreNews());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(),
      child: Scaffold(
          appBar: AppBar(title: const Center(child: Text("News Data"))),
          body: BlocBuilder<NewsBloc, NewsState>(
            bloc: newsBloc,
            builder: (context, state) {
              print("state is !!!!!!!!!!! " + state.toString());
              if (state is NewsLoadedState) {
                print("state is loaded " + state.toString());
                var articles = state.articles;
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
              } else if (state is NewsLoadingState) {
                print("state is loading " + state.toString());
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NewsError) {
                return const Center(
                  child: Text(" There is a error occurred"),
                );
              }
              return Container();
            },
          )),
    );
  }
}
