import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:magnise_test_app/app/currency_rate_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../history_item_model.dart';

class HomeController extends GetxController {
  var textController = new TextEditingController();
  CurrencyRate rate = new CurrencyRate();
  var historyList = List<HistoryItem>.empty(growable: true);
  var candleList = List<Candle>.empty(growable: true).obs;

  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse("wss://ws-sandbox.coinapi.io/v1"),
  );

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    channel.sink.close();
  }

  void doSMTH(String needle) async {
    channel.sink.add(json.encode({
      "type": "hello",
      "apikey": "402047D0-DBD9-44DB-BF87-B040E14C0412",
      "heartbeat": false,
      "subscribe_data_type": ["exrate"],
      "subscribe_filter_asset_id": [needle],
    }));
    Dio dio = Dio();
    try {
      candleList.clear();
      var response = await dio.get(
          "https://rest.coinapi.io/v1/exchangerate/BTC/USD/history?time_start=2022-04-17T15:00:00.000&period_id=1HRS",
          options: Options(headers: {"X-CoinAPI-Key": "402047D0-DBD9-44DB-BF87-B040E14C0412"}));
      for (var item in response.data) {
        var candle = HistoryItem.fromJson(item);
        candleList.add(Candle(
            date: DateTime.parse(candle.timeOpen!),
            high: candle.rateHigh!,
            low: candle.rateLow!,
            open: candle.rateOpen!,
            close: candle.rateClose!,
            volume: 1));
      }
      Get.forceAppUpdate();
    } catch (e) {
      print(e);
    }
  }
}
