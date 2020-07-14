class UserDetails{

  final String email;
  final String mobile;
  final String password;

  UserDetails({this.email, this.mobile, this.password});
  
  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      email: json['email'],
      mobile: json['mobile'],
      password: json['password'],
    );
  }
}