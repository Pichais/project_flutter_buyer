class AccountModel {
  //field
  // ignore: non_constant_identifier_names
  dynamic ID, address, avatar, user, password, name, phone, gender;

  //Method
  AccountModel(this.name, this.ID, this.address, this.avatar, this.user,
      this.password, this.gender, this.phone);

  AccountModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    ID = map['ID'];
    address = map['address'];
    password = map['password'];
    user = map['user'];
    avatar = map['image'];
    phone = map['phone'];
    gender = map['gender'];
  }
}
