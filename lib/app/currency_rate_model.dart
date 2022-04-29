class CurrencyRate {
  DateTime? time;
  String? assetIdBase;
  String? assetIdQuote;
  double? rate;
  String? type;

  CurrencyRate({this.time, this.assetIdBase, this.assetIdQuote, this.rate, this.type});

  CurrencyRate.fromJson(Map<String, dynamic> json) {
    time = DateTime.parse(json['time']);
    assetIdBase = json['asset_id_base'];
    assetIdQuote = json['asset_id_quote'];
    rate = double.parse(json['rate'].toString()); //WS can send int type
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['asset_id_base'] = this.assetIdBase;
    data['asset_id_quote'] = this.assetIdQuote;
    data['rate'] = this.rate;
    data['type'] = this.type;
    return data;
  }
}
