// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String? email;
  String? password;

  User({this.email, this.password});

  User.fromMap(Map<String, dynamic> map) {
    email = map['email'];
    password = map['password'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;

    return data;
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
