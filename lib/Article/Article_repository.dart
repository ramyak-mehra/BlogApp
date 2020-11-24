import 'package:blogapp/Article/index.dart';
import 'package:blogapp/Home/index.dart';

class ArticleRepository {
  final ArticleProvider _articleProvider = ArticleProvider();

  ArticleRepository();

  Future<String> generateHTMLFromMarkdown(Article articleData) {
    return Future.delayed(Duration(seconds: 2))
        .then((value) => articleData.body);
  }
}
