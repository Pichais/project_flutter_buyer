class AccountModel {
  //field
  // ignore: non_constant_identifier_names
  dynamic name, phone, gender, dob, image;

  //Method
  AccountModel(this.name, this.gender, this.phone, this.dob, this.image);

  AccountModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    phone = map['phone'];
    gender = map['gender'];
    dob = map['dob'];
    image = map['image'];
  }
}
