import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blogapp/Featured/index.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({
    Key key,
    @required FeaturedBloc featuredBloc,
  })  : _featuredBloc = featuredBloc,
        super(key: key);

  final FeaturedBloc _featuredBloc;

  @override
  FeaturedScreenState createState() {
    return FeaturedScreenState();
  }
}

class FeaturedScreenState extends State<FeaturedScreen> {
  FeaturedScreenState();

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
    return BlocBuilder<FeaturedBloc, FeaturedState>(
        cubit: widget._featuredBloc,
        builder: (
          BuildContext context,
          FeaturedState currentState,
        ) {
          if (currentState is UnFeaturedState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorFeaturedState) {
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
          if (currentState is InFeaturedState) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: ListView(
                children: [
                  Text('your saved stories'),
                  ListView.builder(itemBuilder: null)
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
    widget._featuredBloc.add(LoadFeaturedEvent(isError));
  }
}
