import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blogapp/Home/index.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
    @required HomeBloc homeBloc,
  })  : _homeBloc = homeBloc,
        super(key: key);

  final HomeBloc _homeBloc;

  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  HomeScreenState();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        cubit: widget._homeBloc,
        builder: (
          BuildContext context,
          HomeState currentState,
        ) {
          if (currentState is UnHomeState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorHomeState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: _load,
                  ),
                ),
              ],
            ));
          }
          if (currentState is InHomeState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  'your saved articles'.richText.bold.xl.make().pOnly(left: 8),
                  SizedBox(height: 20),
                  VxSwiper.builder(
                      aspectRatio: 1.5,
                      initialPage: 0,
                      itemCount: currentState.results.count,
                      itemBuilder: (context, index) {
                        return _buildSavedArticles(
                            currentState.results.results[index]);
                      }),
                  SizedBox(height: 20),
                  'your recommendations'.richText.bold.xl.make().pOnly(left: 8),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: currentState.results.count,
                    itemBuilder: (context, index) {
                      return _buildListTile(
                          currentState.results.results[index]);
                    },
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _load([bool isError = false]) {
    widget._homeBloc.add(LoadHomeEvent());
  }

  Widget _buildListTile(Article article) {
    return Card(
      child: ListTile(
        title: Text(article.title),
        key: Key(article.author.toString()),
        subtitle: Text(
          article.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          widget._homeBloc
              .add(NavigateArticleEvent(article: article, context: context));
        },
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/6f/d6/8c/6fd68ced202b643053e9f281de52a016.jpg'))),
        ),
        trailing: IconButton(
            icon: article.favorited
                ? Icon(Icons.bookmark)
                : Icon(Icons.bookmark_outline_outlined),
            onPressed: () {
              widget._homeBloc
                  .add(FavoriteArticleEvent(articleSlug: article.slug));
            }),
      ),
    );
  }

  Widget _buildSavedArticles(Article article) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://i.pinimg.com/originals/6f/d6/8c/6fd68ced202b643053e9f281de52a016.jpg'))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  article.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 15,
                      backgroundImage: NetworkImage(article.author.image),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(article.author.username),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
