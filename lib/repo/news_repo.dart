import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/news_model.dart';
import 'package:http/http.dart' as http;
// For practice purpose created repo.
class NewsRepository{
   List<NewsModel> articles = [];
  int offset = 0;
  ScrollController scrollController = ScrollController();

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?limit=10&offset=$offset&apiKey=1d72a50bad1a4871a74830e1fa3a457a&q=tesla')
        );
    if (response.statusCode == 200) {
  
        articles.addAll(json.decode(response.body)['articles']);
 
    } else {
      throw Exception('Failed to load news');
    }
  }

  }
