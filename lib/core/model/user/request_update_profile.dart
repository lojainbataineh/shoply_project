class RequestUpdateProfile {
  final String? fullName;
  final String? userName;
  final String? address;
  final String? profileImage;

  RequestUpdateProfile({
    required this.fullName,
    required this.userName,
    required this.address,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'userName': userName,
      'address': address,
      if (profileImage != null) 'profileImage': profileImage,
    };
  }
}
