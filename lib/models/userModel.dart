// class UserModel {
//   String? emailAddress;
//   String? username;
//   String? mobileNumber;
//   String? photo;

//   UserModel({
//     this.emailAddress,
//     this.username,
//     this.mobileNumber,
//     this.photo,
//   });

//   UserModel.fromJson(Map<String, dynamic> json) {
//     emailAddress = json['emailAddress'];
//     username = json['username'];
//     mobileNumber = json['mobileNumber'];
//     photo = json['photo'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['emailAddress'] = emailAddress;
//     data['username'] = username;
//     data['mobileNumber'] = mobileNumber;
//     data['photo'] = photo;
//     return data;
//   }
// }


class UserModel {
  var id; // Add this field
  var emailAddress;
  var username;
  var mobileNumber;
  var photo;

  UserModel({
    this.id, // Include id in the constructor
    this.emailAddress,
    this.username,
    this.mobileNumber,
    this.photo,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id']; // Assign the 'id' field
    emailAddress = json['emailAddress'];
    username = json['username'];
    mobileNumber = json['mobileNumber'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id; // Serialize the 'id' field
    data['emailAddress'] = emailAddress;
    data['username'] = username;
    data['mobileNumber'] = mobileNumber;
    data['photo'] = photo;
    return data;
  }
}
