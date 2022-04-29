import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magnise_test_app/app/currency_rate_model.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          centerTitle: true,
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextField(
                      controller: controller.textController,
                    )),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          controller.doSMTH(controller.textController.text);
                        },
                        child: Text("Submit")))
              ],
            ),
          ),
          Text("Market Data"),
          StreamBuilder(
              stream: controller.channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  controller.rate = CurrencyRate.fromJson(json.decode(snapshot.data.toString()));
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Symbol:"),
                            Text("${controller.rate.assetIdBase}/${controller.rate.assetIdQuote}"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Price:"),
                            Text("${controller.rate.rate}"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Time:"),
                            Text(
                                "${DateFormat('MMMM').format(DateTime(0, controller.rate.time!.month))} ${controller.rate.time!.day}, ${controller.rate.time!.hour} ${DateFormat("hh:mm a").format(controller.rate.time!)}"),
                          ],
                        ),
                      ],
                    ),
                  );
                } else
                  return Text("");
              }),

          Text("Charting data:"),
          Expanded(
            child: Candlesticks(candles: controller.candleList),
          )

          //GRAPH
        ]));
  }
}
