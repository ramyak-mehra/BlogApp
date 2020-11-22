import 'package:equatable/equatable.dart';

class Results {
  int count;
  bool next;
  bool previous;
  List<Article> results;

  Results({this.count, this.next, this.previous, this.results});

  Results.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<Article>();
      json['results'].forEach((v) {
        results.add(new Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Article extends Equatable {
  Author author;
  String body;
  String createdAt;
  String description;
  bool favorited;
  int favoritesCount;
  String slug;
  String title;
  String updatedAt;
  List<String> tagList;

  Article(
      {this.author,
      this.body,
      this.createdAt,
      this.description,
      this.favorited,
      this.favoritesCount,
      this.slug,
      this.title,
      this.updatedAt,
      this.tagList});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        author:
            json['author'] != null ? new Author.fromJson(json['author']) : null,
        body: json['body'],
        createdAt: json['createdAt'],
        description: json['description'],
        favorited: json['favorited'],
        favoritesCount: json['favoritesCount'],
        slug: json['slug'],
        title: json['title'],
        updatedAt: json['updatedAt'],
        tagList: json['tagList'].cast<String>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['body'] = this.body;
    data['createdAt'] = this.createdAt;
    data['description'] = this.description;
    data['favorited'] = this.favorited;
    data['favoritesCount'] = this.favoritesCount;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['updatedAt'] = this.updatedAt;
    data['tagList'] = this.tagList;
    return data;
  }

  @override
  List<Object> get props => [
        author,
        body,
        createdAt,
        description,
        favorited,
        favoritesCount,
        slug,
        title,
        updatedAt,
        tagList
      ];
}

class Author extends Equatable {
  final String username;
  final String bio;
  final String image;
  final bool following;

  Author({this.username, this.bio, this.image, this.following});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
        username: json['username'] as String,
        bio: json['bio'] as String,
        image: json['image'] as String,
        following: json['following'] as bool);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['bio'] = this.bio;
    data['image'] = this.image;
    data['following'] = this.following;
    return data;
  }

  @override
  List<Object> get props => [username, bio, image, following];
}

class HomeModel extends Equatable {
  final int id;
  final String name;

  HomeModel(this.id, this.name);

  @override
  List<Object> get props => [id, name];

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(json['id'] as int, json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
