class User {
  String? id;
  String? email;
  String? name;

  User({this.name, this.email, this.id});

  Map<String, dynamic> toFireStore() {
    return {"id": id, "name": name, "email": email};
  }

  User.fromFireStore(Map<String, dynamic>? data) {
    id = data?["id"];
    name = data?["name"];
    email = data?["email"];
  }
}
