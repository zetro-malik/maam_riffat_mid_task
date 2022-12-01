class User {
  int? ID;
  String username;
  String password;
  String image;

  User(
      {this.ID,
      required this.username,
      required this.password,
      required this.image});

  static fromMap(Map<String, dynamic> map) {
    User a = User(
        ID: map["ID"],
        username: map["username"],
        password: map["password"],
        image: map["image"]);
    return a;
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': this.ID,
      'username': this.username,
      'password': this.password,
      "image": this.image
    };
  }
}
