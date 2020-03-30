

class ItemPriceData {
  List item_price;

  ItemPriceData({this.item_price});

  factory ItemPriceData.fromJson(Map<String, dynamic> json)
  {
    return ItemPriceData(
        item_price: json["item_price"]
    );
  }

}