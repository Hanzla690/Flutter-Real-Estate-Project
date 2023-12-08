class UserModel {
  String id;
  String email;
  String username;
  List activeChats;

  UserModel(
      {required this.id,
      required this.email,
      required this.username,
      this.activeChats = const []});

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'activeChats': activeChats,
    };
  }

  static UserModel fromMap(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        email: json['email'],
        username: json['username'],
        activeChats: json['activeChats']);
  }
}
