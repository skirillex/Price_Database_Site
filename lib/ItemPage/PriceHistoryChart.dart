
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceHistoryChart extends StatelessWidget {
  List<charts.Series> seriesList;
  bool animate;
  List prices;
  DateTime currentDate;
  int daysback;
  // PriceHistoryChart(this.seriesList, this.prices, {this.animate});
  double lowprice;
  var lowpricedate;
  double highprice;
  var highpricedate;

  PriceHistoryChart(List prices,int daysback, bool animate)
  {
    this.prices = prices;
    this.animate = animate;
    this.daysback = daysback;
    this.currentDate = DateTime.now();
    this.seriesList = _loadPriceData();
  }

/*
  factory PriceHistoryChart.withPriceData(){
    return new PriceHistoryChart(
      _loadPriceData(),
      animate: true,
    );
  }

 */

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(seriesList, animate: animate, behaviors: [
      new charts.RangeAnnotation([
        new charts.RangeAnnotationSegment(
            currentDate.subtract(Duration(days: daysback)), currentDate, //new DateTime(currentDate.year, currentDate.month,currentDate.day),
            charts.RangeAnnotationAxisType.domain),
        new charts.LineAnnotationSegment(findLowHighPrice(daysback), charts.RangeAnnotationAxisType.measure, startLabel: "\$${lowprice.toStringAsFixed(2)}", labelStyleSpec: charts.TextStyleSpec(color: charts.MaterialPalette.green.shadeDefault) ,color: charts.MaterialPalette.green.shadeDefault, dashPattern: [4, 4]),
        new charts.LineAnnotationSegment(highprice, charts.RangeAnnotationAxisType.measure, endLabel: "\$${highprice.toStringAsFixed(2)}", labelStyleSpec: charts.TextStyleSpec(color:  charts.MaterialPalette.red.shadeDefault) ,color: charts.MaterialPalette.red.shadeDefault, dashPattern: [4, 4]),
      ]),
      new charts.ChartTitle(" ",subTitle: "Lowest: \$${lowprice.toStringAsFixed(2)} (${new DateFormat.MMMd().format(lowpricedate)})                Highest: \$${highprice.toStringAsFixed(2)} (${new DateFormat.MMMd().format(highpricedate)})", subTitleStyleSpec: charts.TextStyleSpec(color: charts.MaterialPalette.gray.shadeDefault), behaviorPosition: charts.BehaviorPosition.bottom, titleOutsideJustification: charts.OutsideJustification.start),
    ]);
  }
  // TODO possibly add a selection Callback to chart to make selecting points dynamic https://google.github.io/charts/flutter/example/behaviors/selection_callback_example

  // TODO need to add functionality for showing all date ranges

  List<charts.Series<TimeSeriesPriceHistory, DateTime>> _loadPriceData() {

    List<TimeSeriesPriceHistory> data = [];

    for (var i in prices){

      var parsedDate = DateTime.parse(i[1]); // converts date string back to datetime object

      data.add(TimeSeriesPriceHistory(new DateTime( parsedDate.year, parsedDate.month, parsedDate.day), i[0]));
    }
    return [
      new charts.Series<TimeSeriesPriceHistory, DateTime>(
          id: 'Prices ',
          domainFn: (TimeSeriesPriceHistory prices, _) => prices.time,
          measureFn: (TimeSeriesPriceHistory prices, _) => prices.price,
          data: data
      )
    ];
  }

  double findLowHighPrice(int daysprev)
  {
    // helper method to find low price and high price for low and high price calculations in graph
    double lowestPrice = 99999999;
    var lowestPriceDate;
    double highestPrice = 0;
    var highestPriceDate;

    for (var i in prices)
    {
      if (DateTime.parse(i[1]).isAfter(currentDate.subtract(Duration(days: daysprev,))))
      {
        if (i[0] < lowestPrice)
        {
          lowestPrice = i[0];
          lowestPriceDate = DateTime.parse(i[1]);
        }
        if (i[0] > highestPrice)
        {
          highestPrice = i[0];
          highestPriceDate = DateTime.parse(i[1]);
        }
      }
    }
    this.lowprice = lowestPrice;
    this.lowpricedate = lowestPriceDate; //new DateFormat.MMMd(lowestPriceDate);
    this.highprice = highestPrice;
    this.highpricedate = highestPriceDate;

    return lowestPrice;
  }
}

class TimeSeriesPriceHistory {
  final DateTime time;
  final double price;

  TimeSeriesPriceHistory(this.time, this.price);
}