class Store {
  String id = "";
  String title = "";
  String price = "";
  String description = "";
  String category_id = "";
  String category_name = "";
  String image = "";
  String rate = "";
  String count = "";

  Store(this.id, this.title, this.price, this.description, this.category_id, this.category_name, this.image, this.rate, this.count);

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category_id = json['category_id'];
    category_name = json['category_name'];
    image = json['image'];
    rate = json['rate'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category_id'] = category_id;
    data['category_name'] = category_name;
    data['image'] = image;
    data['rate'] = rate;
    data['count'] = count;
    return data;
  }
}