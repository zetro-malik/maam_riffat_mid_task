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

  static fromMap(Map<String, dynamic> car) {
    User a = User(
        ID: car["ID"],
        username: car["username"],
        password: car["password"],
        image: car["image"]);
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

class student {
  int regno;
  String name;
  int age;

  student({required this.regno, required this.name, required this.age});

  static fromMap(Map<String, dynamic> obj) {
    student a =
        student(regno: obj["regNO"], name: obj["stdname"], age: obj["stdage"]);
    return a;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = {
      "regNO": regno,
      "stdname": name,
      "stdage": age,
    };
    return mp;
  }
}
