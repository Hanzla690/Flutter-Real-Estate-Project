class UserModel {
  String id;
  String email;
  String username;
  List activeChats, favorites;

  UserModel(
      {required this.id,
      required this.email,
      required this.username,
      this.activeChats = const [],
      this.favorites = const []});

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'activeChats': activeChats,
      'favorites': favorites,
    };
  }

  static UserModel fromMap(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        email: json['email'],
        username: json['username'],
        activeChats: json['activeChats'],
        favorites: json['favorites']);
  }
}
