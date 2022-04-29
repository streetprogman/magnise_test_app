class HistoryItem {
  String? timePeriodStart;
  String? timePeriodEnd;
  String? timeOpen;
  String? timeClose;
  double? rateOpen;
  double? rateHigh;
  double? rateLow;
  double? rateClose;

  HistoryItem(
      {this.timePeriodStart,
      this.timePeriodEnd,
      this.timeOpen,
      this.timeClose,
      this.rateOpen,
      this.rateHigh,
      this.rateLow,
      this.rateClose});

  HistoryItem.fromJson(Map<String, dynamic> json) {
    timePeriodStart = json['time_period_start'];
    timePeriodEnd = json['time_period_end'];
    timeOpen = json['time_open'];
    timeClose = json['time_close'];
    rateOpen = json['rate_open'];
    rateHigh = json['rate_high'];
    rateLow = json['rate_low'];
    rateClose = json['rate_close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_period_start'] = this.timePeriodStart;
    data['time_period_end'] = this.timePeriodEnd;
    data['time_open'] = this.timeOpen;
    data['time_close'] = this.timeClose;
    data['rate_open'] = this.rateOpen;
    data['rate_high'] = this.rateHigh;
    data['rate_low'] = this.rateLow;
    data['rate_close'] = this.rateClose;
    return data;
  }
}
