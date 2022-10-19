import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:ditonton/data/models/tv/tv_season_detail_model.dart';
import 'package:http/http.dart' as http;

abstract class TVRemoteDataSource {
  Future<List<TVModel>> getAiringTodayTVs();
  Future<List<TVModel>> getOnTheAirTVs();
  Future<List<TVModel>> getPopularTVs();
  Future<List<TVModel>> getTopRatedTVs();
  Future<TVDetailResponse> getTVDetail(int id);
  Future<List<TVModel>> getTVRecommendations(int id);
  Future<List<TVModel>> searchTVs(String query);
  Future<TVSeasonDetailModel> getSeasonDetailTV(int id, int seasonNumber);
}

class TVRemoteDataSourceImpl implements TVRemoteDataSource {
  static const API_KEY = 'api_key=857427d1cb0ec0601f6d4968bef80b26';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TVRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TVModel>> getAiringTodayTVs() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getOnTheAirTVs() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVDetailResponse> getTVDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TVDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTVRecommendations(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getPopularTVs() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTopRatedTVs() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> searchTVs(String query) async {
    final response = await client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVSeasonDetailModel> getSeasonDetailTV(int id, int seasonNumber) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id/season/$seasonNumber?$API_KEY'));

    if (response.statusCode == 200) {
      return TVSeasonDetailModel.fromJson(json.decode(response.body));
    } else
      throw ServerException();
  }
}
