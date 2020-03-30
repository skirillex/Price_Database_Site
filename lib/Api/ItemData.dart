


class ItemData {
  int product_id;
  String name;
  String url;
  String img_url;

  ItemData({this.product_id, this.name, this.img_url, this.url});

  factory ItemData.fromJson(Map<String, dynamic> json)
  {
    return ItemData(
      product_id: json["item_id"],
      name: json["name"],
      url: json["url"],
      img_url: json["img_url"],
    );
  }

}