class LoginModel {
  String useremail;
  String password;

  LoginModel({required this.useremail, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'username': useremail,
      'password': password,
    };
  }
}
