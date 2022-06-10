class ProductModel {
  //field
  dynamic name, price, pathimage, detail, user, type, exp, stock;

  //Method
  ProductModel(this.name, this.price, this.pathimage, this.detail, this.user,
      this.type, this.exp, this.stock);

  ProductModel.fromMap(Map<String, dynamic> map) {
    name = map['Name'];
    price = map['Price'];
    pathimage = map['image'];
    detail = map['Detail'];
    exp = map['EXP'];
    user = map['user'];
    type = map['Type'];
    stock = map['Stock'];
  }
}
