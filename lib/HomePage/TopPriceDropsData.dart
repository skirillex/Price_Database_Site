


class TopPriceDropsData {
  List top_price_drops;

  TopPriceDropsData({this.top_price_drops});

  factory TopPriceDropsData.fromJson(Map<String, dynamic> json)
  {
    return TopPriceDropsData(
      top_price_drops: json["top_price_drops"],
    );
  }
}