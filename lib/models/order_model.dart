class OrderModel {
  dynamic name, price, detail, image, amount, id, idProduct;

  OrderModel(this.name, this.price, this.detail, this.image, this.amount,
      this.id, this.idProduct);

  OrderModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    price = map['price'];
    detail = map['detail'];
    image = map['images'];
    amount = map['amount'];
    id = map['id'];
    idProduct = map['idProduct'];
  }
}
