/**
 * Copyright 2020 david.gonzalez.freelance@gmail.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:sportive_clock/clock/clock_quartz.dart';
import 'package:sportive_clock/clock_theme.dart';

import 'package:sportive_clock/temperature/temperature.dart';
import 'package:sportive_clock/weather/weather.dart';
import 'package:intl/intl.dart' as intl;

enum ClockDisplay { clockLeft, clockRight }

class ClockBuilder extends StatelessWidget {
  ClockBuilder(this.type, this.model, this.theme,
      {this.showWeather = true,
      this.showTemperature = true,
      this.display = ClockDisplay.clockRight});

  final ClockModel model;
  final ClockTheme theme;
  final ClockType type;

  bool showTemperature;
  bool showWeather;
  ClockDisplay display;

  @override
  Widget build(BuildContext context) {
    List<Widget> components = List<Widget>();
    if (showWeather || showTemperature) {
      components.add(Expanded(
        flex: 2,
        child: buildWeatherAndTemperature(),
      ));
    }
    components.add(Center(
      child: buildClock(context),
    ));

    switch (display) {
      case ClockDisplay.clockLeft:
        components = List.of(components.reversed);
        break;
      default:
        break;
    }

    return ClockThemeWidget(
        theme: theme,
        brightness: Theme.of(context).brightness,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: components,
        ));
  }

  Widget buildWeatherAndTemperature() {
    if (!showTemperature && !showWeather) {
      return Container(width: 0, height: 0);
    }
    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[],
    );
    if (showTemperature) {
      column.children.add(Expanded(
          flex: 1,
          child: Padding(
              padding: EdgeInsets.only(top: 12, left: 12, right: 12),
              child: TemperatureWidget(
                  min: model.low,
                  max: model.high,
                  current: model.temperature,
                  unit: model.unitString))));
    }
    if (showWeather) {
      column.children.add(Expanded(
        flex: 2,
        child:
            Weather(location: model.location, forecast: model.weatherCondition),
      ));
    }
    return column;
  }

  Widget buildClock(BuildContext context) {
    String date = intl.DateFormat.MMMMEEEEd().format(DateTime.now());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: AspectRatio(aspectRatio: 1, child: ClockQuartz(type, model)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            date,
            style: theme.computeTextStyle(Theme.of(context).brightness),
          ),
        )
      ],
    );
  }
}
