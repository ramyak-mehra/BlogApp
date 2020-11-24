import 'dart:async';
import 'package:blogapp/Home/Home_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meta/meta.dart';

class HomeProvider {
  static const String baseUrl = 'http://192.168.1.10:8000/api';
  static const String baseArticleUrl = '$baseUrl/articles';
  static const Map<String, String> baseHeaders = {
    'Authorization': 'Basic c2Ftbnl1OnRlc3RpbmcxMjM0'
  };
  static String commentGenerator(String commentBody) {
    final String commentRequest = """ {
"comment":{
"body":"$commentBody"}

}""";
    return jsonEncode(commentRequest);
  }

  Future<Results> getAllArticles() async {
    http.Response res = await http.get(baseArticleUrl);
    if (res.statusCode == 200) {
      return Results.fromJson(jsonDecode(res.body));
    }
    throw Exception('No Articles Could Be Fetched');
  }

  Future<bool> followArticle({@required String articleSlug}) async {
    http.Response res = await http
        .post(baseArticleUrl + '/$articleSlug/favorite/', headers: baseHeaders);

    if (res.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> unfollowArtice({@required String articleSlug}) async {
    http.Response res = await http.delete(
        baseArticleUrl + '/$articleSlug/favorite/',
        headers: baseHeaders);
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> deleteComment(
      {@required String articleSlug, @required int commentId}) async {
    http.Response res = await http.delete(
        baseArticleUrl + '/$articleSlug/comments/$commentId',
        headers: baseHeaders);
    if (res.statusCode == 204) {
      return true;
    }
    return false;
  }

  Future<Results> getRecommendedArticles() async {
    http.Response res =
        await http.get(baseArticleUrl + '/feed', headers: baseHeaders);
    if (res.statusCode == 200) {
      return Results.fromJson(jsonDecode(res.body));
    }
    throw Exception('No Articles Could Be Fetched');
  }

  Future<bool> createComment(
      {@required String articleSlug, @required String commentBody}) async {
    http.Response res = await http.post(
        baseArticleUrl + '/$articleSlug/comments/',
        headers: baseHeaders,
        body: commentGenerator(commentBody));
    if (res.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future getAllComments({@required String articleSLug}) async {
    http.Response res =
        await http.get(baseArticleUrl + '/$articleSLug/comments');
    if (res.statusCode == 200) {}
  }
}
