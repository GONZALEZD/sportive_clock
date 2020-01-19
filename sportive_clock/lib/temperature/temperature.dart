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

import 'package:flutter/material.dart';
import 'package:sportive_clock/clock_theme.dart';
import 'painter/ladder.dart';
import 'dart:math' as math;

class TemperatureWidget extends StatelessWidget {
  TemperatureWidget({this.min, this.max, this.current, this.unit});

  final double min;
  final double max;
  final double current;
  final String unit;

  int nbMarkers() {
    int markersCount = (max - min + 1).round();
    return math.min(8, markersCount);
  }

  @override
  Widget build(BuildContext context) {
    ClockTheme theme = ClockThemeWidget.of(context).theme;
    Color bgColor = theme.backgroundColor[300];
    if (ClockThemeWidget.of(context).brightness == Brightness.dark) {
      bgColor = theme.backgroundColor[500];
    }
    TextStyle style = ClockThemeWidget.of(context).textStyle();
    Color primaryColor = style.color;
    TextStyle textStyle = ClockThemeWidget.of(context).textStyle();
    final bgTextStyle = textStyle.copyWith(color: bgColor);
    double currentPercent = (current - min) / (max - min);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        temperatureText("${current.round()}", unit, currentPercent, textStyle),
        Row(
          children: <Widget>[
            secondaryText("${min.round()}", bgTextStyle),
            Expanded(
              child: Container(
                height: 24,
                child: CustomPaint(
                  painter: LadderPainter(
                      color: primaryColor,
                      backgroundColor: bgColor,
                      lineWidth: 2,
                      nbMarkers: nbMarkers(),
                      currentPercent: currentPercent),
                ),
              ),
            ),
            secondaryText("${max.round()}", bgTextStyle),
          ],
        )
      ],
    );
  }

  Widget temperatureText(
      String text, String unit, double leftPercent, TextStyle style) {
    int left = (leftPercent * 100).round();
    int right = 100 - left;
    return Row(
      children: <Widget>[
        Spacer(flex: left),
        Flexible(
          flex: right,
          child: Text(
            "$text$unit",
            style: style,
          ),
        )
      ],
    );
  }

  Widget secondaryText(String text, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: style),
    );
  }
}
