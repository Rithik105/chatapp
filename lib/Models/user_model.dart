class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? profilePic;

  UserModel({this.email, this.fullname, this.profilePic, this.uid});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    email = map["email"];
    profilePic = map["profilePic"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "email": email,
      "profilepic": profilePic
    };
  }
}
