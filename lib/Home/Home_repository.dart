import 'package:blogapp/Home/index.dart';

class HomeRepository {
  final HomeProvider _homeProvider = HomeProvider();

  HomeRepository();

  Future<Results> getAllArticles() async {
    try {
      return _homeProvider.getAllArticles();
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return null;
    }
  }

  Future<bool> followArticle(String articleSlug) async {
    return _homeProvider.followArticle(articleSlug: articleSlug);
  }
}
