class UserData {
  String firstName;
  String lastName;
  String phoneNumber;
  String token;

  UserData({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.token,
  });



  factory UserData.fromJson(Map<dynamic, dynamic>? json) {
    if (json == null) {
      // Handle the case where the entire JSON is null
      return UserData(
        firstName: '',
        lastName: '',
        phoneNumber: '',
        token: '',
      );
    }

    return UserData(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      token: json['token'] ?? '',
    );
  }


  // Add this method to convert the UserData object to a Map
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'token': token,
    };
  }
}
