class UserProfile {
  String firstName;
  String lastName;
  String userName;
  String email;

  String imageUrl;

  String firebaseUid;
  String notaryId;
  String role;
  String bio;

  UserProfile(
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.imageUrl,
    this.firebaseUid,
    this.notaryId,
    this.role,
    this.bio,
  );
  String getNotaryId() {
    return notaryId;
  }

  //Json to object :
  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        json["firstName"],
        json["lastName"],
        json["username"],
        json["email"],
        json["photoURL"],
        json["uid"],
        json["_id"],
        json["role"],
        json["bio"],
      );

  Map<String, dynamic> toJson() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'username': this.userName,
      'email': this.email,
      'photoURL': this.imageUrl,
      'uid': this.firebaseUid,
      '_id': this.notaryId,
      'role': this.role,
      'bio': this.bio,
    };
  }
}
