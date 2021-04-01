class UserProfile
{
  String _displayName;
  String _uid;
  String _email;

  UserProfile({
    String displayName = '',
    String email = '',
    String uid = ''
  }) : _uid = uid,
      _displayName = displayName,
      _email = email;


  String getDisplayName() {
    return _displayName;
  }

  String getEmail() {
    return _email;
  }

  String getUid() {
    return _uid;
  }

  factory UserProfile.fromJson(Map<String, dynamic> parsedJson){
    return new UserProfile(
      uid: parsedJson['uid'] ?? '',
      displayName: parsedJson['displayName'] ?? '',
      email: parsedJson['email'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': this._email,
      'uid': this._uid,
      'displayName': this._displayName
    };
  }
}

