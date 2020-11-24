import 'package:blogapp/Featured/index.dart';

class FeaturedRepository {
  final FeaturedProvider _featuredProvider = FeaturedProvider();

  FeaturedRepository();

  void test(bool isError) {
    _featuredProvider.test(isError);
  }
}