class AccesCredentials{
  final String User;
  final String Password;

  AccesCredentials({required this.User, required this.Password});

  factory AccesCredentials.fromJson(Map<String, dynamic> json) {
    return AccesCredentials(
      User: json['user'],
      Password: json['password'] 
    );
  }
}