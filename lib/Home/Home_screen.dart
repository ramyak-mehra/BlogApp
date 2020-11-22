import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blogapp/Home/index.dart';

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
            return Center(
                child: ListView.builder(
                    itemCount: currentState.results.count,
                    itemBuilder: (context, index) {
                      Results res = currentState.props[1];

                      return _buildListTile(res.results[index]);
                    }));
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
        leading: CircleAvatar(
          child: Text(article.favoritesCount.toString()),
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
}
