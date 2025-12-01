class User {
  String email;
  String fullName;

  User({this.email = '', this.fullName = ''});

  Map<String, String> toMap() => {
        'email': email,
        'fullName': fullName,
      };

  factory User.fromMap(Map<String, dynamic> map) => User(
        email: map['email'] ?? '',
        fullName: map['fullName'] ?? '',
      );

  @override
  String toString() => 'User(email: $email, fullName: $fullName)';
}
